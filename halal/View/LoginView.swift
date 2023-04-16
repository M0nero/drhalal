//
//  LoginView.swift
//  halal
//
//  Created by Damir Akbarov on 11.05.2022.
//

import SwiftUI
import FirebaseCore

struct LoginView: View {
//    @StateObject private var appleService = FirebaseSignInWithAppleService()
    
    @StateObject private var viewModel = LoginViewModelImpl(
        service: LoginServiceImpl()
    )
    @State private var alertShow: AlertSystem?
    
    @State private var showRegistration = false
    @State private var showForgotPassword = false
    
    var body: some View {
        VStack {
            VStack{
                
                VStack {
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: getRect().width/3, height: getRect().height/5)
                    VStack{
                        
                        HStack(spacing: 8){
                            Text("Don't Have An Account ?")
                                .foregroundColor(Color.gray.opacity(0.5))
                            Button(action: {
                                
                                showRegistration.toggle()
                                
                            }) {
                                
                                Text("Sign Up")
                                
                            }.foregroundColor(.black)
                            
                        }.padding(.bottom, 20)
                        
                    }.sheet(isPresented: $showRegistration) {
                        RegisterView()
                    }
                    
                }.padding(.bottom)
                VStack(alignment: .leading){
                    
                    InputTextFieldView(text: $viewModel.credentials.email, title: "E-mail", placeholder: "Enter your email address", keyboardType: .emailAddress).padding(.bottom, 5)
                    
                    VStack(alignment: .leading){
                        Text("Password").font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
                        LoginSecureTextField(text: $viewModel.credentials.password)
                        Divider()
                    }
                    HStack {
                        Spacer()
                        Button(action: {
                            showForgotPassword.toggle()
                        }, label: {
                            Text("Forgot Password?")
                        })
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.black)
                        .sheet(isPresented: $showForgotPassword) {
                            ForgotPasswordView()
                        }
                    }.padding(.top, 5)
                }
                
                ButtonView(title:"Sign in") {
                    Task {
                        do {
                            try await viewModel.login()
                        } catch {
                            print(error.localizedDescription)
                            alertShow = AlertSystem(title: "Error", message: error.localizedDescription)
                        }
                    }
                }
                .padding(.top, 35)
                
            }.padding()
                .alert(item: $alertShow){ show in
                    Alert(title: Text(show.title), message: Text(show.message), dismissButton: .default(Text("OK")))
                }
            Spacer()
            VStack{
                HStack{
                    RoundedRectangle(cornerRadius: 50)
                        .fill(Color.gray)
                        .frame(height: 3)
                        .padding()
                    Text("or sign in with")
                        .foregroundColor(Color.gray.opacity(0.9))
                        .fontWeight(.light)
                        .baselineOffset(5)
                    RoundedRectangle(cornerRadius: 50)
                        .fill(Color.gray)
                        .frame(height: 3)
                        .padding()
                }
                
                HStack(spacing: 45){
                    Button {
//                        signInWithApple()
                    } label: {
                        Image(systemName: "applelogo")
                            .scaleEffect(1.3)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.black)
                            .clipShape(Circle())
                            .scaleEffect(1.25)
                    }
                    Button {
                        Task {
                            do {
                                try await viewModel.signInWithGoogle()
                            } catch {
                                print(error.localizedDescription)
                            }
                        }
                    } label:{
                        Image("google")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 58, height: 58)
                    }
                }
            }
            .padding(.bottom, 5)
        }
        
        
    }
    
//    func signInWithApple(){
//        appleService.signIn { result in
//            handleAppleServiceSuccess(result)
//        } onFailed: { err in
//            handleAppleServiceError(err)
//        }
//    }
    
//    func handleAppleServiceSuccess(_ result: FirebaseSignInWithAppleResult) {
//        let uid = result.uid
//        let firstName = result.token.appleIDCredential.fullName?.givenName ?? ""
//
//        print(uid)
//        print(firstName)
//    }
    
    func handleAppleServiceError(_ error: Error) {
        print(error.localizedDescription)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
