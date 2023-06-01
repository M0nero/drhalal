//
//  ProductBarView.swift
//  halal
//
//  Created by Damir Akbarov on 22.05.2023.
//

import SwiftUI
import NukeUI

struct ProductBarView: View {
    
    var product: Product
    
    var body: some View {
        ZStack {
            HStack {
                LazyImage(source: product.img, resizingMode: .aspectFill)
                    
                Text("\(product.name)")
                    .frame(minWidth: UIScreen.main.bounds.width/2, maxWidth: .infinity, alignment: .center)
                Spacer()
                switch product.halalStatus {
                case 1:
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                        .dynamicTypeSize(.xxxLarge)
                        .imageScale(.large)
                case 2:
                    Image(systemName: "multiply.circle.fill")
                        .foregroundColor(.red)
                        .dynamicTypeSize(.xxxLarge)
                        .imageScale(.large)
                case 3:
                    Image(systemName: "questionmark.circle.fill")
                        .foregroundColor(.black)
                        .dynamicTypeSize(.xxxLarge)
                        .imageScale(.large)
                default:
                    Text("--ERROR--")
                }
            }
            .padding(.horizontal, 10)
            RoundedRectangle(cornerRadius: 13)
                .stroke(Color.gray, lineWidth: 1)
                .background(Color.clear)
        }
        .frame(maxWidth: .infinity, minHeight: UIScreen.main.bounds.height/10)
        .padding(.vertical, 5)
        .padding(.horizontal)
    }
}
