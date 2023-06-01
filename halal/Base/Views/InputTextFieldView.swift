//
//  InputTextFieldView.swift
//  halal
//
//  Created by Damir Akbarov on 10.05.2023.
//

import SwiftUI

struct InputTextFieldView: View {
    
    @Binding var text: String
    let title: String
    let placeholder: String
    let keyboardType: UIKeyboardType
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text(title).font(.headline).fontWeight(.light).foregroundColor(Color.init(.label).opacity(0.75))
            
            HStack {
                TextField(placeholder, text: $text)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .keyboardType(keyboardType)
            }
            
            Divider()
            
        }.padding(.bottom, 10)
    }
}
