//
//  String?+isNilOrEmpty.swift
//  RxCocoaMVVMExampleLoginForm
//
//  Created by oe on 2021/10/30.
//

import Foundation

extension Optional where Wrapped == String {
    var isNilOrEmpty: Bool {
        self?.isEmpty ?? true
    }
}
