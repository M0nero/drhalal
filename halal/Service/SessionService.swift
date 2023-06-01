//
//  SessionService.swift
//  halal
//
//  Created by Damir Akbarov on 11.05.2023.
//

import Foundation
import FirebaseAuth
import FirebaseDatabase
import Combine

enum SessionState {
    case loggedIn
    case loggedOut
    case undefined
}

struct UserSessionDetails {
    let userName: String
    let profileImgUrl: String
    let email: String
    let anonymous: Bool
}

protocol SessionService {
    var state: SessionState { get }
    var userDetails: UserSessionDetails? { get }
    init()
    func logout()
    func updateUserSession()
}

final class SessionServiceImpl: SessionService, ObservableObject {
    
    @Published var state: SessionState = .undefined
    @Published var userDetails: UserSessionDetails?
    
    private var handler: AuthStateDidChangeListenerHandle?
    private var subscriptions = Set<AnyCancellable>()
    
    init() {
        setupObservations()
    }
    
    deinit {
        unbind()
        print("deinit SessionServiceImpl")
    }
    
    func logout() {
        try? Auth.auth().signOut()
        state = .loggedOut
    }
    
    func updateUserSession() {
        unbind()
        handler = Auth
            .auth()
            .addStateDidChangeListener { [weak self] _, _ in
                guard let self = self else { return }
                
                let currentUser = Auth.auth().currentUser
                self.state = currentUser == nil ? .loggedOut : .loggedIn
                if currentUser != nil {
                    guard let anonymous = currentUser?.isAnonymous,
//                          let userName = currentUser?.displayName,
                          let email = currentUser?.email
                    else {
                        print("handle Error")
                        return
                    }
                    let userName = currentUser?.displayName ?? ""
                    let profileImgUrl = currentUser?.photoURL?.absoluteString ?? ""
                    DispatchQueue.main.async {
                        self.userDetails = UserSessionDetails(userName: userName,
                                                              profileImgUrl: profileImgUrl,
                                                              email: email,
                                                              anonymous: anonymous)
                    }
                }
            }
    }
}

private extension SessionServiceImpl {
    func unbind() {
        guard let handler = handler else { return }
        Auth.auth().removeStateDidChangeListener(handler)
    }
    
    func setupObservations() {
        handler = Auth
            .auth()
            .addStateDidChangeListener { [weak self] _, _ in
                guard let self = self else { return }
                
                let currentUser = Auth.auth().currentUser
                self.state = currentUser == nil ? .loggedOut : .loggedIn
                if currentUser != nil {
                    guard let anonymous = currentUser?.isAnonymous,
//                          let userName = currentUser?.displayName,
                          let email = currentUser?.email
                    else {
                        print("handle Error")
                        return
                    }
                    let userName = currentUser?.displayName ?? ""
                    let profileImgUrl = currentUser?.photoURL?.absoluteString ?? ""
                    DispatchQueue.main.async {
                        self.userDetails = UserSessionDetails(userName: userName,
                                                              profileImgUrl: profileImgUrl,
                                                              email: email,
                                                              anonymous: anonymous)
                    }
                }
            }
    }
}
