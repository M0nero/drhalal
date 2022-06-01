//
//  ProfileImageView.swift
//  halal
//
//  Created by Damir Akbarov on 17.05.2022.
//
import NukeUI
import SwiftUI

struct EditProfileImageView: View {
    
    @State var imgUrl: String
    @Binding var avatarImage: SwiftUI.Image?
    
    var body: some View {
        if avatarImage != nil {
            avatarImage!
                .resizable()
                .frame(width: getRect().height/7.5, height: getRect().height/7.5)
                .clipShape(Circle())
        }
        else if imgUrl != "" {
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

//struct ProfileImageView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileImageView(imgUrl: )
//    }
//}
