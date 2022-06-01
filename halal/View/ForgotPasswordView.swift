//
//  ForgotPasswordView.swift
//  halal
//
//  Created by Damir Akbarov on 11.05.2022.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @Environment(\.presentationMode) var presentationMode

    @StateObject private var viewModel = ForgotPasswordViewModelImpl(
        service: ForgotPasswordServiceImpl()
    )
    
    var body: some View {
        NavigationView{
            VStack(spacing: 16) {
            
                InputTextFieldView(text: $viewModel.email, title: "",
                                   placeholder: "Email",
                                   keyboardType: .emailAddress)
                
                ButtonView(title: "Send Password Reset") {
                    Task {
                        do {
                            try await viewModel.sendPasswordResetRequest()
                        } catch {
                            print(error.localizedDescription)
                            //alertShow = AlertSystem(title: "Error", message: error.localizedDescription)
                        }
                    }
                    
                    presentationMode.wrappedValue.dismiss()
                }
            }
            .padding(.horizontal, 15)
            .navigationTitle("Reset Password")
        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
