//
//  SecureFiled.swift
//  halal
//
//  Created by Damir Akbarov on 17.05.2022.
//

import SwiftUI

struct SecureFieldView: View {
    @Binding var text: String
    @State var isTapped: Bool = false
    let title: String
    
    var body: some View {
        VStack{
            VStack(alignment: .leading, spacing: 4, content:{
                SecureField("", text: $text)
                    .onAppear(){
                        if text != ""{
                            withAnimation(.easeIn){
                                // moving hint to top..
                                isTapped = true
                            }
                        }
                        
                    }
                    .onChange(of: text){ (status) in
                        if text == ""{
                            withAnimation(.easeOut){
                                isTapped = false
                            }
                        } else {
                            withAnimation(.easeIn){
                                // moving hint to top..
                                isTapped = true
                            }
                        }
                    }
                .padding (.top, isTapped ? 15 : 0)
                .background(
                    Text(title)
                        .scaleEffect (isTapped ? 0.8:1)
                        .offset(x: isTapped ? -7 : 0, y: isTapped ? -15 : 0)
                        .foregroundColor(.gray)
                    , alignment: .leading
                )
            })
            .padding(.vertical, 12)
            .padding(.horizontal)
            
            //.background(Color.gray.opacity(0.09))
            .overlay(
                RoundedRectangle(cornerRadius: 9)
                    .stroke(.gray, lineWidth: 1)
            )
            //.cornerRadius(5)
        }.padding()
    }
}

struct SecureFiled_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }
    struct PreviewWrapper: View {
        @State(initialValue: "") var text1: String
        @State(initialValue: "") var text2: String
        var body: some View {
            VStack{
                SecureFieldView(text: $text1, title: "Pass")
                SecureFieldView(text: $text2, title: "Password")
            }
        }
    }
}
