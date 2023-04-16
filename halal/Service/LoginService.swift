//
//  LoginService.swift
//  halal
//
//  Created by Damir Akbarov on 11.05.2022.
//

import Combine
import Foundation
import FirebaseAuth
import FirebaseCore
import FirebaseDatabase
import GoogleSignIn

protocol LoginService {
    func login(with credentials: LoginCredentials) -> Future<Any, Error>
    func signInWithGoogle()-> Future<Any, Error>
}

struct LoginCredentials {
    var email: String
    var password: String
}
enum LoginKeys: String {
    case userName
    case profileImgUrl
    //case email
}

final class LoginServiceImpl: LoginService {
    func signInWithGoogle()-> Future<Any, Error>{
        Future { [self] promise in
            guard let clientID = FirebaseApp.app()?.options.clientID else { return }
            
            // Create Google Sign In configuration object.
            let config = GIDConfiguration(clientID: clientID)
            
            GIDSignIn.sharedInstance.signIn(with: config, presenting: getRootViewController()){[self] user, error in
                if let err = error {
                    promise(.failure(err))
                }
                guard
                    let authentication = user?.authentication,
                    let idToken = authentication.idToken
                else {
                    return
                }
                guard let user = user else { return }
                
                let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                               accessToken: authentication.accessToken)
                
                let profileInfo = [user.profile?.name ?? user.profile?.givenName ?? "", user.profile?.imageURL(withDimension: 320)!] as [Any]
                
                Auth.auth().signIn(with:credential){ result, error in
                    if let err = error {
                        promise(.failure(err))
                    } else {
                        if let user = result?.user {
                    
                            let changeRequest = user.createProfileChangeRequest()
                            changeRequest.displayName = profileInfo[0] as? String
                            changeRequest.photoURL = profileInfo[1] as? URL
                            changeRequest.commitChanges { error in
                                if let err = error {
                                    promise(.failure(err))
                                } else {
                                    promise(.success(()))
                                }
                            }
                        }
                    }
                    
                }
                
            }
        }
        
    }
    
    func login(with credentials: LoginCredentials) -> Future<Any, Error> {
        
        Future { promise in
            
            Auth
                .auth()
                .signIn(withEmail: credentials.email,
                        password: credentials.password) { res, error in
                    
                    if let err = error {
                        promise(.failure(err))
                    } else {
                        promise(.success(()))
                    }
                }
        }
    }
}
