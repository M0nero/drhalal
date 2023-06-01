//
//  Request.swift
//  halal
//
//  Created by Damir Akbarov on 21.05.2023.
//

import Foundation
import Combine

protocol Request {
    func send<TData: Decodable>(_ endpoint: Endpoint) -> AnyPublisher<TData, Error>
    func send<TData: Decodable, UData: Encodable>(_ endpoint: Endpoint, payload: UData) -> AnyPublisher<TData, Error>
//    func send<TData: Encodable>(_ endpoint: Endpoint, payload: TData) -> Completable
}
