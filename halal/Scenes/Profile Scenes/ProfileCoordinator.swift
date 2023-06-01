//
//  ProfileCoordinator.swift
//  halal
//
//  Created by Damir Akbarov on 14.05.2023.
//

import SwiftUI

protocol ProfileFlowStateProtocol: ObservableObject {
    var activeLink: ProfileLink? { get set }
}

enum ProfileLink: Hashable, Identifiable {
    case editSheetLink(name: String, imgUrl: String)
    
    var navigationLink: ProfileLink {
        switch self {
        default: return self
        }
    }
    
    var sheetItem: ProfileLink {
        switch self {
        case .editSheetLink:
            return self
        }
    }
    
    var id: String {
        switch self {
        case .editSheetLink:
            return "edit"
        }
    }
}

struct ProfileFlowCoordinator<State: ProfileFlowStateProtocol, Content: View>: View {
    @ObservedObject var state: State
    let content: () -> Content
    
    private var activeLink: Binding<ProfileLink?> {
        $state.activeLink.map(get: { $0?.navigationLink }, set: { $0 })
    }
    
    private var sheetItem: Binding<ProfileLink?> {
        $state.activeLink.map(get: { $0?.sheetItem }, set: { $0 })
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                content()
                    .sheet(item: sheetItem, content: sheetContent)
                
                navigationLinks
            }
        }
        .navigationViewStyle(.stack)
    }
    
    @ViewBuilder private var navigationLinks: some View {
        EmptyView()
    }
    
    @ViewBuilder private func sheetContent(sheetItem: ProfileLink) -> some View {
        switch sheetItem {
        case let .editSheetLink(name, imgUrl):
            EditProfileView(userName: name, imgUrl: imgUrl)
        }
    }
}
