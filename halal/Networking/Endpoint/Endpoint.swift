//
//  Endpoint.swift
//  halal
//
//  Created by Damir Akbarov on 21.05.2023.
//

import Alamofire

protocol Endpoint {
    var scheme: String { get }
    var httpMethod: HTTPMethod { get }
    var host: String { get }
    var path: String { get }
    var params: [String: String] { get }
    var headers: HTTPHeaders { get }
}

extension Endpoint {
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "halal-api.onrender.com"
//        return "192.168.3.44"
    }
    
    var headers: HTTPHeaders {
        return ["Accept": "application/json",
                "Content-Type": "application/json"]
    }
 }
