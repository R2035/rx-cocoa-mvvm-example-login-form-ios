//
//  LoginViewModel.swift
//  RxCocoaMVVMExampleLoginForm
//
//  Created by oe on 2021/10/19.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

struct LoginViewModel {
    struct Input {
        let id: Observable<String?>
        let password: Observable<String?>
        let loginButtonTap: Observable<Void>
    }

    struct Output {
        let id: Driver<String?>
        let password: Driver<String?>
        let isLoginButtonEnabled: Driver<Bool>
    }

    private let exampleApi: ExampleApi

    init(exampleApi: ExampleApi) {
        self.exampleApi = exampleApi
    }

    func tranform(input: Input) -> Output {
        let id = input.id.asDriver(onErrorDriveWith: .empty())

        let password = input.password.asDriver(onErrorDriveWith: .empty())

        let isLoginButtonEnabled = Observable.combineLatest(input.id, input.password) { id, password in
            LoginViewModel.validate(id: id, password: password)
        }.asDriver(onErrorDriveWith: .empty())

        return Output(
            id: id,
            password: password,
            isLoginButtonEnabled: isLoginButtonEnabled
        )
    }

    private static func validate(id: String?, password: String?) -> Bool {
        !id.isNilOrEmpty && !password.isNilOrEmpty
    }
}
