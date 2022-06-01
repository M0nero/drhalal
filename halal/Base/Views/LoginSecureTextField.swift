//
//  SecureTextField.swift
//  halal
//
//  Created by Damir Akbarov on 10.05.2022.
//

import SwiftUI

struct LoginSecureTextField: View {
    @State var isSecureField: Bool = true
    @Binding var text: String
    
    var body: some View {
        HStack{
            if isSecureField{
                SecureField("Enter your password", text: $text)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            } else {
                TextField(text, text: $text)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }
            
            ZStack(){
                Image(systemName: isSecureField ? "eye.slash" : "eye")
                    .onTapGesture {
                        isSecureField.toggle()
                    }
            }
        }
    }
}
