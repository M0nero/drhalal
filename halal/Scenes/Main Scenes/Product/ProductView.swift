//
//  ProductView.swift
//  halal
//
//  Created by Damir Akbarov on 01.05.2023.
//

import SwiftUI
import NukeUI

struct ProductView: View {
    // MARK: - Properties
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ProductViewModel
    
    var body: some View {
        ZStack(alignment: .top) {
            TopPartDetailView(product: viewModel.product)
                .frame(maxHeight: getRect().height/3)
                .ignoresSafeArea()
                .zIndex(0)
            Button {
                dismiss()
            } label: {
                SwiftUI.Image(systemName: "xmark")
                    .font(.title3)
                    .foregroundColor(.black)
                    .padding(4)
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.gray, lineWidth: 1)
                    )
            }
            .padding(.trailing)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .zIndex(1)
            VStack {
                Spacer()
                    .frame(height: getRect().height/3)
                VStack(alignment: .leading) {
                    HeaderDetailView(product: viewModel.product)
                    DescriptionDetailView(product: viewModel.product)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .clipShape(CustomShape())
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.black, lineWidth: 1)
                                        .shadow(color: Color.black.opacity(0.8),
                                                radius: 4, x: 0, y: -5)
                }
            }
            .zIndex(1)
            .ignoresSafeArea()
        }
        .background(Color(UIColor.secondarySystemBackground))
    }
}

struct TopPartDetailView: View {
    @State private var isAnimating: Bool = false
    var product: Product
    
    var body: some View {
        HStack(alignment: .center) {
            LazyImage(source: product.img, resizingMode: .aspectFill)
                .offset(y: isAnimating ? 0 : -35)
        }
        .onAppear(perform: {
            withAnimation(.easeOut(duration: 0.75)) {
                isAnimating.toggle()
            }
        })
    }
}

struct HeaderDetailView: View {
    // MARK: - Properties
    var product: Product
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            Text(product.name)
                .font(.title)
                .fontWeight(.black)
        }
        .foregroundColor(.black)
        .padding(.top, 10)
    }
}

struct DescriptionDetailView: View {
    // MARK: - Properties
    var product: Product
    
    // MARK: - Body
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            Text(product.description)
                .font(.system(.body, design: .rounded))
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
        }
    }
}
