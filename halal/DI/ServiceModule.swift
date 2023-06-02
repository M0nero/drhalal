//
//  ServiceModule.swift
//  halal
//
//  Created by Damir Akbarov on 24.05.2023.
//

import Foundation
import Swinject
import SwinjectAutoregistration

struct ServiceModule {
    func registerDependencies(in container: Container) {
        container.autoregister(ProductServiceProtocol.self, initializer: ProductService.init)
        container.autoregister(SubcategoryServiceProtocol.self, initializer: SubcategoryService.init)
        container.autoregister(LoginService.self, initializer: LoginServiceImpl.init)
        container.autoregister(RegistrationService.self, initializer: RegistrationServiceImpl.init)
        container.autoregister(ForgotPasswordService.self, initializer: ForgotPasswordServiceImpl.init)
    }
}
