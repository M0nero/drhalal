//
//  SearchCoordinatorView.swift
//  halal
//
//  Created by Damir Akbarov on 26.04.2023.
//

import SwiftUI
import NukeUI

struct SearchCoordinatorView: View {
    
    @ObservedObject var coordinator: SearchCoordinator
    
    init(coordinator: SearchCoordinator) {
        self.coordinator = coordinator
        Theme.navigationBarColors(background: UIColor(named: "color"),
                                  titleColor: UIColor(named: "titleColor"),
                                  tintColor: UIColor(named: "titleColor"))
    }
    
    var body: some View {
        NavigationView {
            VStack {
                getProductsList(coordinator.productsListViewModel)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("Поисковик")
            .navigationBarTitleDisplayMode(.inline)
        }
        .searchable(text: $coordinator.productsListViewModel.keyword, placement: .sidebar) {
            if coordinator.productsListViewModel.keyword.isEmpty {
                ForEach(coordinator.viewModel.lastRequests.reversed(), id: \.self) { request in
                    Text("\(request)")
                        .searchCompletion(request)
                }
            }
        }
        .disableAutocorrection(true)
        .textInputAutocapitalization(.never)
        .navigationViewStyle(.stack)
    }
    
    @ViewBuilder
    private func getProductsList(_ viewModel: ProductsListViewModel) -> some View {
        ProductsListView(
            viewModel: viewModel,
            productModifier: FullScreenCoverModifier(item: $coordinator.productViewModel) { viewModel in
                ProductView(viewModel: viewModel)
            }
        )
    }
}
