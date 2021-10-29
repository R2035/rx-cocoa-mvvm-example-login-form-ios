//
//  ExampleApiStub.swift
//  RxCocoaMVVMExampleLoginForm
//
//  Created by oe on 2021/10/30.
//

import Foundation
import RxSwift

final class ExampleApiStub: ExampleApi {
    func login(id: String, password: String) -> Single<ExampleApiResult> {
        .create { observer -> Disposable in
            if Bool.random() {
                observer(.success(.succeeded))
            } else {
                observer(.success(.failed))
            }
            return Disposables.create()
        }
        .delay(.milliseconds(500), scheduler: MainScheduler.instance)
    }
}
