//
//  RegistrationService.swift
//  halal
//
//  Created by Damir Akbarov on 11.05.2023.
//

import Combine
import Foundation
import FirebaseAuth
import FirebaseDatabase

struct RegistrationCredentials {
    
    var email: String
    var password: String
    var userName: String
    var profileImgUrl: String
    
}

protocol RegistrationService {
    func register(with credentials: RegistrationCredentials) -> Future<Any, Error>
    func signInAnonymously() -> Future<Any, Error>
}

enum RegistrationKeys: String {
    case userName
    case profileImgUrl
//    case email
}

final class RegistrationServiceImpl: RegistrationService {
    
    func signInAnonymously() -> Future<Any, Error> {
        Future { promise in
            Auth.auth().signInAnonymously { res, error in
                if let err = error {
                    promise(.failure(err))
                } else {
                    promise(.success(()))
                }
            }
            
        }
    }
    
    func register(with credentials: RegistrationCredentials) -> Future<Any, Error> {
        
        Future { promise in
            
            Auth.auth().createUser(withEmail: credentials.email,
                                   password: credentials.password) { res, error in
                
                if let err = error {
                    promise(.failure(err))
                } else {
                    
                    if let user = res?.user {
                        let changeRequest = user.createProfileChangeRequest()
                        changeRequest.displayName = credentials.userName
                        changeRequest.commitChanges { error in
                            if let err = error {
                                promise(.failure(err))
                            } else {
                                user.reload()
                                promise(.success(()))
                            }
                        }
                    }
                    
                }
            }
        }
    }
}
