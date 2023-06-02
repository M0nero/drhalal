//
//  DIWrappers.swift
//  halal
//
//  Created by Damir Akbarov on 02.06.2023.
//

import Swinject
import SwiftUI

@propertyWrapper
struct Inject<I> {
    let wrappedValue: I
    init() {
        self.wrappedValue = Resolver.shared.resolve(I.self)
    }
}

@propertyWrapper
public struct InjectedObject<Service>: DynamicProperty where Service: ObservableObject {
 
    @ObservedObject private var service: Service
    
    public init() {
        self.service = Resolver.shared.resolve(Service.self)
    }
    
    public var wrappedValue: Service {
        get { return service }
        mutating set { service = newValue }
    }
    
    public var projectedValue: ObservedObject<Service>.Wrapper {
        return self.$service
    }
}

@propertyWrapper
public struct InjectedStateObject<Service>: DynamicProperty where Service: ObservableObject {
    @StateObject private var service: Service
    
    public init() {
        self._service = StateObject(wrappedValue: Resolver.shared.resolve(Service.self))
    }
    
    public var wrappedValue: Service {
        return service
    }
    
    public var projectedValue: ObservedObject<Service>.Wrapper {
        return self.$service
    }
}

class Resolver {
    static let shared = Resolver()
    
    var container = Container()
    
    func resolve<T>(_ type: T.Type) -> T {
        container.resolve(T.self)!
    }
}
