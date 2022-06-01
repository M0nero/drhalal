//
//  ProfileView.swift
//  halal
//
//  Created by Damir Akbarov on 26.04.2022.
//

import SwiftUI
import NukeUI

struct ProfileView: View {
    
    @EnvironmentObject var service: SessionServiceImpl
    @State private var showingAlert = false
    @State private var showEditProfile = false
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        NavigationView{
            VStack(spacing: 0){
                HStack(alignment: .center){
                    VStack{
                        HStack(alignment: .top){
                            Text("dr.halal").font(.custom("RobotoCondensed-Bold", size: 30)).foregroundColor(Color(UIColor(named: "titleColor")!))
                            Spacer()
                            Button(action: {
                                showingAlert.toggle()
                            }) {
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                                
                                //.resizable()
                                    .dynamicTypeSize(.xxxLarge)
                                    .imageScale(.large)
                                    .foregroundColor(.black)
                                
                            }
                        }.frame(width: getRect().width-35)
                        VStack{
                            ProfileImageView(imgUrl: service.userDetails?.profileImgUrl ?? "")
                            
                            Text(service.userDetails?.userName ?? "")
                                .font(.title).bold()
                                .foregroundColor(Color(UIColor(named: "titleColor")!))
                            Text(service.userDetails?.email ?? "").foregroundColor(Color(UIColor(named: "titleColor")!))
                        }
                        
                        
                    }
                    
                }.frame(width: getRect().width, height: getRect().height/3.1).background(Color(UIColor(named: "color")!))
                //Spacer()
                ButtonView(title: "Edit my account", indent: 200) {
                    showEditProfile.toggle()
                }
                .frame(minWidth: 0, maxWidth: .infinity)
                .padding(.top)
                .background(Color(UIColor(named: "homeColor") ?? .black))
                .sheet(isPresented: $showEditProfile) {
                    EditProfileView(userName: service.userDetails?.userName ?? "", imgUrl: service.userDetails?.profileImgUrl ?? "")
                }
                SettingsView(settings: service.userDetails?.anonymous ?? true ? viewModel.settingsForAnonymous : viewModel.settings)
                
                
                    .alert(isPresented: $showingAlert) {
                        Alert(
                            title: Text("Are you sure?"),
                            message: Text("Logging out will require you to log in again to scan a product or create a new account. Are you sure you would like to log out?"),
                            primaryButton: .destructive(Text("Leave")) {
                                Task {
                                    do {
                                        try await viewModel.logout()
                                    } catch {
                                        print(error.localizedDescription)
                                    }
                                }
                            },
                            secondaryButton: .cancel()
                        )
                    }
                    .navigationBarHidden(true)
            }
        }.onAppear(){
            service.updateUserSession()
        }
        
        
    }
}
struct SettingsView: View{
    let settings: [Setting]
    @State var isShowingUpdatePassword: Bool = false
    var body: some View{
        Form{
            Button {
                isShowingUpdatePassword.toggle()
            } label: {
                Text("Изменить пароль")
            }

            Section{
                ForEach(settings, id:\.id){ setting in
                    NavigationLink(destination: EmptyView()){
                        Label{
                            Text(setting.name)
                            
                        } icon: {
                            Image(systemName: setting.img)
                                .foregroundColor(.black)
                        }
                        
                    }
                }
            }.sheet(isPresented: $isShowingUpdatePassword) {
                UpdatePasswordView()
            }
//            Section{
//                Toggle (isOn: .constant (true),
//                        label:{
//                    Text("Dark mode")
//                })
//
//            }
//            .foregroundColor(.black)
//            .font (.system (size: 16, weight: .semibold))
        }
    }
}
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(SessionServiceImpl())
    }
}
