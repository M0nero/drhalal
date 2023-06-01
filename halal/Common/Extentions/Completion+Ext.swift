//
//  Completion+Ext.swift
//  halal
//
//  Created by Damir Akbarov on 23.05.2023.
//

import Combine

extension Subscribers.Completion {
    func error() throws -> Failure {
        if case let .failure(error) = self {
            return error
        }
        throw ErrorFunctionThrowsError.error
    }
    
    private enum ErrorFunctionThrowsError: Error { case error }
}
