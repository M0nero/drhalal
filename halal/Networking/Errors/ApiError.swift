//
//  ApiError.swift
//  halal
//
//  Created by Damir Akbarov on 21.05.2023.
//

import Foundation

enum ApiError: Error {
    case convertUrlError
    case emptyResponseError
    case notSuccessfulHttpCode(code: Int, response: String)
}

extension ApiError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .convertUrlError:
            return "Can not convert URL"
        case .emptyResponseError:
            return "Response is Empty"
        case .notSuccessfulHttpCode:
            return "notSuccessfulHttpCode"
        }
    }
}
