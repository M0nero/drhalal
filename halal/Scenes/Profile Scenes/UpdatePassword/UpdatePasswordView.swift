//
//  UpdatePasswordView.swift
//  halal
//
//  Created by Damir Akbarov on 17.05.2023.
//

import SwiftUI

struct UpdatePasswordView: View {
    @State private var currentPass: String = ""
    @State private var pass: String = ""
    @State private var repass: String = ""
    var body: some View {
        VStack {
            Text("Change password").font(.title2).frame(width: getRect().width - 30, height: getRect().height / 15, alignment: .leading)
            SecureFieldView(text: $currentPass, title: "Your current password")
            SecureFieldView(text: $pass, title: "Enter your new password")
            SecureFieldView(text: $repass, title: "Confirm your password")
            Spacer()
            ButtonView(title: "Update your password") {
                
            }
        }
    }
}

struct UpdatePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        UpdatePasswordView()
    }
}
