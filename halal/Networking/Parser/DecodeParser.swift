//
//  DecodeParser.swift
//  halal
//
//  Created by Damir Akbarov on 21.05.2023.
//

import Foundation
import Combine

final class DecodeParser: Parser {
    let decoder: JSONDecoder = JSONDecoder()
    let encoder: JSONEncoder = JSONEncoder()
    
    func decode<T: Decodable>(_ data: Data) -> AnyPublisher<T, Error> {
        Deferred {
            Future { promise in
                do {
                    let response = try self.decoder.decode(T.self, from: data)
                    promise(.success(response))
                } catch {
                    promise(.failure(ParseError.noValidJSON))
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
    func encode<T: Encodable>(_ data: T) -> Data? {
        encoder.outputFormatting = .prettyPrinted
        return try? encoder.encode(data)
    }
}
