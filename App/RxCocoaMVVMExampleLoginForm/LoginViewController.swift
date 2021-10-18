//
//  LoginViewController.swift
//  RxCocoaMVVMExampleLoginForm
//
//  Created by oe on 2021/10/19.
//

import UIKit

final class LoginViewController: UITableViewController {
    @IBOutlet private var idTextField: UITextField!

    @IBOutlet private var passwordTextField: UITextField!

    @IBOutlet private var loginButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}
