//
//  SubcategoriesView.swift
//  halal
//
//  Created by Damir Akbarov on 23.05.2023.
//

import SwiftUI
import NukeUI

struct SubcategoriesView: View {
    // MARK: - Properties
    @ObservedObject var viewModel: SubcategoriesViewModel
//    @InjectedStateObject private var listViewModel: ProductsListViewModel
    
    let columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 2)
    
    var body: some View {
        ScrollView {
            Spacer()
            LazyVGrid(columns: columns, spacing: 10) {
                ForEach(viewModel.subcategories) { item in
                    ItemView(item: item)
                        .buttonStyle(ItemButtonStyle(cornerRadius: 20))
                        .onNavigation {
                            viewModel.open(item)
                        }
                }
            }
            .padding(.horizontal)
        }
        .background(Color.white)
        .navigationTitle(viewModel.categoryName)
    }
}

// MARK: - ItemView
struct ItemView: View {
    let item: Subcategory
    
    var body: some View {
        GeometryReader { reader in
            
            let fontSize = min(reader.size.width * 0.2, 20)
//            let imageWidth: CGFloat = min(60, reader.size.width * 0.6)
            
            VStack(spacing: 5) {
                LazyImage(source: item.img,
                          resizingMode: .aspectFill)
                    .frame(width: reader.size.width)
                
                Text(item.name)
                    .font(.system(size: fontSize, weight: .semibold, design: .rounded))
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.black.opacity(0.9))
                    .padding(.bottom)
            }
            .frame(width: reader.size.width, height: reader.size.height)
            .background(Color.white)
        }
        .frame(height: 150)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.2), radius: 10, y: 5)
    }
}

// MARK: - ItemButtonStyle
struct ItemButtonStyle: ButtonStyle {
    let cornerRadius: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        ZStack {
            configuration.label
            
            if configuration.isPressed {
                Color.black.opacity(0.2)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .shadow(color: .black.opacity(0.2), radius: 10, y: 5)
    }
}
