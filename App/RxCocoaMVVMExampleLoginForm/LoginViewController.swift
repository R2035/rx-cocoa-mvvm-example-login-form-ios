//
//  LoginViewController.swift
//  RxCocoaMVVMExampleLoginForm
//
//  Created by oe on 2021/10/19.
//

import RxCocoa
import RxSwift
import UIKit

final class LoginViewController: UITableViewController {
    @IBOutlet private var idTextField: UITextField!

    @IBOutlet private var passwordTextField: UITextField!

    @IBOutlet private var loginButton: UIButton!

    private let viewModel = LoginViewModel()

    private let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        let output = viewModel.tranform(input: LoginViewModel.Input(
            id: idTextField.rx.text.asObservable(),
            password: passwordTextField.rx.text.asObservable(),
            loginButtonTap: loginButton.rx.tap.asObservable()
        ))

        output.id.drive(idTextField.rx.text).disposed(by: disposeBag)

        output.password.drive(passwordTextField.rx.text).disposed(by: disposeBag)

        output.isLoginButtonEnabled.drive(loginButton.rx.isEnabled).disposed(by: disposeBag)
    }
}
