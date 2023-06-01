//
//  HomeCoordinatorView.swift
//  halal
//
//  Created by Damir Akbarov on 26.04.2023.
//

import SwiftUI
import ACarousel

struct HomeCoordinatorView: View {
    
    @ObservedObject var coordinator: HomeCoordinator
    let roles = ["sushi", "aviata", "pizza"]
    
    var body: some View {
        NavigationView {
            VStack {
                VStack {
                    Text("dr.halal").font(.custom("RobotoCondensed-Bold", size: 30)).foregroundColor(.green)
                    Text("Kazakhstan").font(.caption)
                }.frame(maxWidth: getRect().width-35, alignment: .leading)
                
                ACarousel(roles, id: \.self, spacing: 15, isWrap: true, autoScroll: .active(10)) { name in
                    Image(name)
                        .resizable()
                        .scaledToFill()
                        .frame(width: getRect().width-55, height: getRect().height/5)
                        .cornerRadius(25)
                }
                .frame(height: getRect().height/5)
                Spacer()
                Text("Категории")
                    .font(.system(size: 25, weight: .medium, design: .rounded))
                    .padding(.horizontal, 20)
                    .padding(.bottom, 5)

                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    .background(Color(UIColor(named: "homeColor") ?? .black))
                ZStack(alignment: .bottom) {
                    CategoryList(viewModel: coordinator.viewModel)
                        .navigation(item: $coordinator.subcategoriesViewModel) { viewModel in
                            openSubcategories(viewModel)
                        }
                    
                }.zIndex(-1)
                    .hiddenNavigationBarStyle()
            }.background(Color(UIColor(named: "homeColor") ?? .black))
        }
        .navigationViewStyle(.stack)
        .tint(.white)
    }
    
    @ViewBuilder
    private func openSubcategories(_ viewModel: SubcategoriesViewModel) -> some View {
        SubcategoriesView(viewModel: viewModel)
            .navigation(item: $coordinator.productsListViewModel) { viewModel in
                openProductsList(viewModel)
            }
    }
    
    @ViewBuilder
    private func openProductsList(_ viewModel: ProductsListViewModel) -> some View {
        ProductsListView(
            viewModel: viewModel,
            productModifier: FullScreenCoverModifier(item: $coordinator.productViewModel) { viewModel in
                ProductView(viewModel: viewModel)
            }
        )
    }
}
