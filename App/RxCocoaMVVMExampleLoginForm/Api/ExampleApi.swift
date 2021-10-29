//
//  ExampleApi.swift
//  RxCocoaMVVMExampleLoginForm
//
//  Created by oe on 2021/10/30.
//

import Foundation
import RxSwift

protocol ExampleApi {
    func login(id: String, password: String) -> Single<ExampleApiResult>
}
