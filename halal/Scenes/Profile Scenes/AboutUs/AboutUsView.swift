//
//  AboutUsView.swift
//  halal
//
//  Created by Damir Akbarov on 02.06.2023.
//

import SwiftUI

struct AboutUsView: View {
    
    let links = [
        (name: "Дамир Акбаров", url: "https://t.me/M0_onero", image: "apple"),
        (name: "Даниал Жусупов", url: "https://t.me/daniel_hechterr", image: "brain"),
        (name: "Диас Серiк", url: "https://t.me/Serdiz", image: "android")
    ]
    
    var body: some View {
        VStack {
            Spacer()
            
            Image("Logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 150)
            
            Spacer()
            
            ForEach(links, id: \.name) { link in
                HStack {
                    Image(link.image)
                        .resizable()
                        .frame(width: 30, height: 30)
                    
                    Link(destination: URL(string: link.url)!) {
                        Text(link.name)
                            .font(.title)
                            .foregroundColor(.black)
                    }
                }.padding()
            }
            Spacer()
        }
        .padding()
    }
}
