//
//  ProductsListView.swift
//  halal
//
//  Created by Damir Akbarov on 23.05.2023.
//

import SwiftUI

struct ProductsListView<ProductModifier: ViewModifier>: View {
    
    @ObservedObject var viewModel: ProductsListViewModel
    let productModifier: ProductModifier
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    ForEach(viewModel.queryResultProducts) { product in
                        ProductBarView(product: product)
                            .buttonStyle(.plain)
                            .simultaneousGesture(TapGesture().onEnded {
                                if viewModel.flow == .search {
                                    viewModel.processLastSearch()
                                }
                                viewModel.open(product)
                            })
                            .animation(.default, value: viewModel.keyword)
                            .modifier(productModifier)
                    }
                }
                switch viewModel.state {
                case .good:
                    Color.clear
                        .onAppear {
                            viewModel.getNextData()
                        }
                case .isLoading:
                    ProgressView()
                        .progressViewStyle(.circular)
                        .frame(maxWidth: .infinity)
                case .loadedAll:
                    EmptyView()
                case .error(let message):
                    Text(message)
                        .foregroundColor(.pink)
                }
            }
            if viewModel.isEmptyProducts {
                VStack {
                    Spacer()
                    Image("empty")
                        .resizable()
                        .scaledToFit()
                        .frame(width: getRect().width/1.5, height: getRect().width/1.5)
                    Spacer()
                }
            }
        }
    }
}
