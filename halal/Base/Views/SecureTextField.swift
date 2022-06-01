//
//  SecureTextField.swift
//  halal
//
//  Created by Damir Akbarov on 10.05.2022.
//

import SwiftUI

struct SecureTextField: View {
    @Binding var pass: String
    let title: String
    let placeholder: String
    
    var body: some View {
        VStack(alignment: .leading){

            Text(title).font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
            
            SecureField(placeholder, text: $pass)
            
            Divider()
        }.padding(.bottom, 10)
    }
}
