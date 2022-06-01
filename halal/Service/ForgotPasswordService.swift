//
//  ForgotPasswordService.swift
//  halal
//
//  Created by Damir Akbarov on 11.05.2022.
//

import Foundation
import Firebase
import Combine

protocol ForgotPasswordService {
    func sendPasswordResetRequest(to email: String) -> Future<Any, Error>
}

final class ForgotPasswordServiceImpl: ForgotPasswordService {
    
    func sendPasswordResetRequest(to email: String) -> Future<Any, Error> {
        
        Future { promise in
            Auth
                .auth()
                .sendPasswordReset(withEmail: email) { error in
                    
                    if let err = error {
                        promise(.failure(err))
                    } else {
                        promise(.success(()))
                    }
                }
        }
        
    }
}
