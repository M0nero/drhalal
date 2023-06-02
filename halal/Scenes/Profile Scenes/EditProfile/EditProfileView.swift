//
//  EditProfileView.swift
//  halal
//
//  Created by Damir Akbarov on 17.05.2023.
//

import SwiftUI
import FirebaseAuth
import Combine

struct EditProfileView: View {
    @State private var isShowingPhotoPicker = false
    @State private var image: Image?
    @State private var avatarImage: UIImage?
    @State var userName: String
    @State var imgUrl: String
    @EnvironmentObject var service: SessionServiceImpl
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        VStack {
            Spacer()
            EditProfileImageView(imgUrl: imgUrl, avatarImage: $image)
                .onTapGesture {
                    isShowingPhotoPicker.toggle()
            }
            
            TextFieldView(text: $userName, title: "Имя")
            Spacer()
            ButtonView(title: "Сохранить") {
                updateDisplayName(userName: userName)
                self.presentationMode.wrappedValue.dismiss()
            }
        }
        .onChange(of: avatarImage) { _ in loadImage() }
        .sheet(isPresented: $isShowingPhotoPicker) {
            PhotoPicker(avatarImage: self.$avatarImage)
        }
    }
    
    func loadImage() {
        guard let avatarImage = avatarImage else { return }
        image = Image(uiImage: avatarImage)
    }
    
    func updateDisplayName(userName: String) {
        guard let user = Auth.auth().currentUser else {return}
        let changeRequest = user.createProfileChangeRequest()
        changeRequest.displayName = userName
        changeRequest.commitChanges { error in
            if let err = error {
                print(err.localizedDescription)
            } else {
                print("nice")
                user.reload()
                service.updateUserSession()
            }
        }
    }
}
