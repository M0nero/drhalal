//
//  RegisterView.swift
//  halal
//
//  Created by Damir Akbarov on 11.05.2022.
//

import SwiftUI
import Firebase

struct RegisterView : View {
    
    @StateObject private var viewModel = RegistrationViewModelImpl(
        service: RegistrationServiceImpl()
    )
    @State private var alertShow: AlertSystem?
    
    @State private var repass = ""
    
    var body : some View{
        
        VStack{
            Text("Sign Up").fontWeight(.heavy).font(.largeTitle).padding([.top,.bottom], 20)
            
            VStack(alignment: .leading){
                
                InputTextFieldView(text: $viewModel.newUser.userName, title: "Username", placeholder: "Your username", keyboardType: .namePhonePad)
                
                InputTextFieldView(text: $viewModel.newUser.email, title: "E-mail", placeholder: "Enter your email address", keyboardType: .emailAddress)
                
                SecureTextField(pass: $viewModel.newUser.password, title: "Password", placeholder: "Enter your password")
                
                SecureTextField(pass: $repass, title: "Confirm Password", placeholder: "Retype your password")
                
            }.padding(.horizontal, 6)
            
            
            
            ButtonView(title: "Sign Up") {
                if (viewModel.newUser.password == repass){
                    Task {
                        do {
                            try await viewModel.create()
                        } catch {
                            print(error.localizedDescription)
                            alertShow = AlertSystem(title: "Error", message: error.localizedDescription)
                        }
                    }
                    
                    
                } else if (repass.isEmpty){
                    alertShow = AlertSystem(title: "Confirm Password", message: "Please, repeat your password")
                }
                else {
                    alertShow = AlertSystem(title: "Confirm Password", message: "Those passwords didn't match. Try again.")
                }
                
            }
            .padding(.top, 45)
            
            Button(action: {
                Task {
                    do {
                        try await viewModel.signInAnonymously()
                    } catch {
                        print(error.localizedDescription)
                        alertShow = AlertSystem(title: "Error", message: error.localizedDescription)
                    }
                }
            }){
                Text("Skip registration").foregroundColor(Color.black).font(.headline).padding()
                
            }
            
        }.padding()
            .alert(item: $alertShow){ show in
                Alert(title: Text(show.title), message: Text(show.message), dismissButton: .default(Text("OK")))
                
            }
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegisterView()
    }
}
