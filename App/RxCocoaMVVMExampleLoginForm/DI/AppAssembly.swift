//
//  AppAssembly.swift
//  RxCocoaMVVMExampleLoginForm
//
//  Created by oe on 2021/10/30.
//

import Foundation
import Swinject

final class AppAssembly: Assembly {
    // MARK: Assembly

    public func assemble(container: Container) {
        container.register(LoginViewModel.self) { resolver in
            LoginViewModel(exampleApi: resolver.resolve())
        }

        container.register(ExampleApi.self) { _ in
            ExampleApiStub()
        }
    }
}
