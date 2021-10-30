//
//  LoginViewModel.swift
//  RxCocoaMVVMExampleLoginForm
//
//  Created by oe on 2021/10/19.
//

import Foundation
import RxCocoa
import RxSwift
import RxSwiftExt
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
        let presentAlert: Signal<Alert>
        let showProgress: Signal<Void>
        let dismissProgress: Signal<Void>
    }

    private let exampleApi: ExampleApi

    init(exampleApi: ExampleApi) {
        self.exampleApi = exampleApi
    }

    func tranform(input: Input) -> Output {
        let id = input.id.asDriver(onErrorDriveWith: .empty())

        let password = input.password.asDriver(onErrorDriveWith: .empty())

        let isLoginButtonEnabled = Observable
            .combineLatest(input.id, input.password, resultSelector: LoginViewModel.validate)
            .asDriver(onErrorDriveWith: .empty())

        let idAndPassword = Observable
            .combineLatest(input.id.unwrap(), input.password.unwrap())

        let loginApiResult = input.loginButtonTap
            .withLatestFrom(idAndPassword) { $1 }
            .flatMapLatest { id, password in
                exampleApi.login(id: id, password: password)
            }

        let alert = loginApiResult
            .map(LoginViewModel.alert(for:))
            .asSignal(onErrorSignalWith: .empty())

        let showProgress = input.loginButtonTap.asSignal(onErrorSignalWith: .empty())

        let dismissProgress = loginApiResult.mapTo(()).asSignal(onErrorSignalWith: .empty())

        return Output(
            id: id,
            password: password,
            isLoginButtonEnabled: isLoginButtonEnabled,
            presentAlert: alert,
            showProgress: showProgress,
            dismissProgress: dismissProgress
        )
    }

    private static func validate(id: String?, password: String?) -> Bool {
        !id.isNilOrEmpty && !password.isNilOrEmpty
    }

    private static func alert(for apiResult: ExampleApiResult) -> Alert {
        switch apiResult {
        case .succeeded:
            return .loginSucceeded
        case .failed:
            return .loginFailed
        }
    }
}
