//
//  AsyncPromise.swift
//  halal
//
//  Created by Damir Akbarov on 15.04.2023.
//

import Combine

public struct AsyncPromise<T> {
    @MainActor
    @discardableResult
    public static func fulfill(_ promise: Future<T, Error>, storedIn cancellables: inout Set<AnyCancellable>) async throws -> T {
        try await withCheckedThrowingContinuation({ continuation in
            promise.sink { result in
                switch result {
                case .finished:
                    break
                case .failure(let err):
                    continuation.resume(throwing: err)
                }
            } receiveValue: { value in
                continuation.resume(returning: value)
            }
            .store(in: &cancellables)
        })
    }
}
