//
//  LoginViewController.swift
//  RxCocoaMVVMExampleLoginForm
//
//  Created by oe on 2021/10/19.
//

import JGProgressHUD
import RxCocoa
import RxSwift
import UIKit

final class LoginViewController: UITableViewController {
    @IBOutlet private var idTextField: UITextField!

    @IBOutlet private var passwordTextField: UITextField!

    @IBOutlet private var loginButton: UIButton!

    private let viewModel: LoginViewModel = AppDelegate.assembler.resolver.resolve()

    private let disposeBag = DisposeBag()

    private let hud = JGProgressHUD()

    override func viewDidLoad() {
        super.viewDidLoad()

        let output = viewModel.tranform(input: LoginViewModel.Input(
            id: idTextField.rx.text.asObservable(),
            password: passwordTextField.rx.text.asObservable(),
            loginButtonTap: loginButton.rx.tap.asObservable()
        ))

        output.id
            .drive(idTextField.rx.text)
            .disposed(by: disposeBag)

        output
            .password.drive(passwordTextField.rx.text)
            .disposed(by: disposeBag)

        output.isLoginButtonEnabled
            .drive(loginButton.rx.isEnabled)
            .disposed(by: disposeBag)

        output.alert
            .emit(onNext: { [weak self] alert in
                self?.present(alert: alert)
            })
            .disposed(by: disposeBag)

        output.showProgress
            .emit(onNext: { [weak self] in
                self?.showProgress()
            })
            .disposed(by: disposeBag)

        output.dismissProgress
            .emit(onNext: { [weak self] in
                self?.dismissProgress()
            })
            .disposed(by: disposeBag)
    }

    private func present(alert: Alert) {
        switch alert {
        case .loginSucceeded:
            let alertController = UIAlertController(title: nil, message: "成功", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                alertController.dismiss(animated: true)
            }))
            present(alertController, animated: true)
        case .loginFailed:
            let alertController = UIAlertController(title: nil, message: "失敗", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
                alertController.dismiss(animated: true)
            }))
            present(alertController, animated: true)
        }
    }

    private func showProgress() {
        hud.show(in: view)
    }

    private func dismissProgress() {
        hud.dismiss()
    }
}
