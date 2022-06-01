//
//  ProfileImageView.swift
//  halal
//
//  Created by Damir Akbarov on 17.05.2022.
//

import SwiftUI
import NukeUI

struct ProfileImageView: View {
    @State var imgUrl: String
    
    var body: some View {
        if imgUrl != "" {
            LazyImage(source: imgUrl)
                .frame(width: getRect().height/7.5, height: getRect().height/7.5)
                .clipShape(Circle())
        }
        else {
            SwiftUI.Image(systemName: "person.crop.circle.fill")
                .resizable()
                .frame(width: getRect().height/7.5, height: getRect().height/7.5)
                .foregroundColor(Color.gray)
                .background(Color.white)
                .clipShape(Circle())
        }
    }
}
