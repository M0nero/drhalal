//
//  NetworkModule.swift
//  halal
//
//  Created by Damir Akbarov on 24.05.2023.
//

import Foundation
import Swinject
import SwinjectAutoregistration

struct NetworkModule {
    func registerDependencies(in container: Container) {
        container.autoregister(Request.self, initializer: AFRequest.init)
        container.autoregister(ProductApiController.self, initializer: ProductApiController.init)
        container.autoregister(SubcategoryApiController.self, initializer: SubcategoryApiController.init)
        container.autoregister(Parser.self, initializer: DecodeParser.init)
    }
}
