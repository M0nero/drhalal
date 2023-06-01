//
//  AppModule.swift
//  halal
//
//  Created by Damir Akbarov on 24.05.2023.
//

import Foundation
import Swinject
import SwinjectAutoregistration

struct AppModule {
    func registerDependencies(in container: Container) {
        container.autoregister(ProductsListViewModel.self, initializer: ProductsListViewModel.init)
        container.autoregister(SearchViewModel.self, initializer: SearchViewModel.init)
        container.autoregister(SubcategoriesViewModel.self, initializer: SubcategoriesViewModel.init)
        container.autoregister(HomeViewModel.self, initializer: HomeViewModel.init)
        container.autoregister(ProfileViewModel.self, initializer: ProfileViewModel.init)
    }
}
