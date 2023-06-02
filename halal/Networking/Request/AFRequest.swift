//
//  AFRequest.swift
//  halal
//
//  Created by Damir Akbarov on 21.05.2023.
//

import Foundation
import Alamofire
import Combine

final class AFRequest: Request {
    private let sessionManager: Session
    private let parser: Parser
    
    init() {
        let configuration = URLSessionConfiguration.af.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 60
        sessionManager = Session(configuration: configuration)
        parser = DecodeParser()
    }
    
    func send<TData: Decodable>(_ endpoint: Endpoint) -> AnyPublisher<TData, Error> {
        return convertToUrl(from: endpoint)
            .flatMap { self.request($0) }
            .flatMap { self.parser.decode($0) }
            .eraseToAnyPublisher()
    }
    
    func send<TData: Decodable, UData: Encodable>(_ endpoint: Endpoint, payload: UData) -> AnyPublisher<TData, Error> {
        return convertToUrl(from: endpoint, payload: payload)
            .flatMap { self.request($0) }
            .flatMap { self.parser.decode($0) }
            .eraseToAnyPublisher()
    }
    
    private func request(_ url: URLRequest, withoutResponse: Bool = false) -> AnyPublisher<Data, Error> {
        Deferred {
            Future { promise in
                Log.log(for: url)
                
                let startTime = Date()
                
                self.sessionManager.request(url)
                    .validate()
                    .responseData { response in
                        
                        Log.log(response: response.response,
                                data: response.data,
                                error: response.error,
                                startRequestTime: startTime,
                                endRequestTime: Date())
                        
                        guard let responseData = response.data else {
                            if withoutResponse {
                                promise(.success(Data()))
                            }
                            promise(.failure(ApiError.emptyResponseError))
                            return
                        }
                        
                        let code = response.response?.statusCode ?? 0
                        guard 200...299 ~= code else {
                            if let stringResponse = String(data: responseData, encoding: .utf8) {
                                promise(.failure(ApiError.notSuccessfulHttpCode(code: code, response: stringResponse)))
                            }
                            return
                        }
                        
                        switch response.result {
                        case .success(let value):
                            promise(.success(value))
                        case .failure(let error):
                            promise(.failure(error))
                        }
                    }
            }
        }
        .eraseToAnyPublisher()
    }
    
    private func convertToUrl<T: Encodable>(from endpoint: Endpoint, payload: T?) -> AnyPublisher<URLRequest, Error> {
        Deferred {
            Future { promise in
                var components = URLComponents()
                components.scheme = endpoint.scheme
                components.host = endpoint.host
                components.path = endpoint.path
                let filteredParams = endpoint.params.filter { $0.value != "" }
                components.queryItems = filteredParams.compactMap { URLQueryItem(name: $0, value: $1) }
                guard let url = components.url else {
                    promise(.failure(ApiError.convertUrlError))
                    return
                }
                var urlRequest = URLRequest(url: url)
                urlRequest.method = endpoint.httpMethod
                urlRequest.headers = endpoint.headers
                if let payload = payload {
                    urlRequest.httpBody = self.parser.encode(payload)
                }
                
                promise(.success(urlRequest))
            }
        }
        .eraseToAnyPublisher()
    }
    
    private func convertToUrl(from endpoint: Endpoint) -> AnyPublisher<URLRequest, Error> {
        convertToUrl(from: endpoint, payload: nil as AnyNil?)
    }
}
