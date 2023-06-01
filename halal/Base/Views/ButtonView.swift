//
//  ButtonView.swift
//  halal
//
//  Created by Damir Akbarov on 11.05.2023.
//

import SwiftUI

struct ButtonView: View {
    
    typealias ActionHandler = () -> Void
    let title: String
    let background: Color
    let foreground: Color
    let border: Color
    let handler: ActionHandler
    let indent: Int
    
//    private let cornerRadius: CGFloat=10
    
    internal init (title: String,
                   background: Color = Color("color"),
                   foreground: Color = .white,
                   border: Color = .clear,
                   indent: Int = 120,
                   handler: @escaping ButtonView.ActionHandler) {
        self.title = title
        self.background = background
        self.foreground = foreground
        self.border = border
        self.indent = indent
        self.handler = handler
    }
    var body: some View {
        Button(action: handler) {
            
            Text(title).foregroundColor(.white).frame(width: getRect().width - CGFloat(indent)).padding()
            
        }.background(Color("color"))
            .clipShape(Capsule())
    }
}

struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(title: "Sign in", handler: {})
    }
}
