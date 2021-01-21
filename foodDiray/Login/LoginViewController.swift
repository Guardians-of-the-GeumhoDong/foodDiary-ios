//
//  LoginViewController.swift
//  Lamoti
//
//  Created by Suhong Jeong on 2020/10/29.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    private var vm : LoginViewModel?

    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        vm = LoginViewModel()
        vm?.delegate = self
    
        vm?.loginJTI()
    }

    override func viewWillDisappear(_ animated: Bool) {
        vm?.delegate = nil
        vm = nil
    }
    
    func checkEnableLogin() {
        if passwordText.text!.isEmpty || emailText.text!.isEmpty {
            loginButton.isUserInteractionEnabled = false
            loginButton.backgroundColor = .lightGray
        } else {
            loginButton.isUserInteractionEnabled = true
            loginButton.backgroundColor = .systemRed
        }
    }

    @IBAction func loginEvent(_ sender: UIButton) {
        vm?.login(email: emailText.text, password: passwordText.text)
    }
    
    @IBAction func emailEditChange(_ sender: UITextField) {
        checkEnableLogin()
    }
    
    @IBAction func passwordEditChange(_ sender: UITextField) {
        checkEnableLogin()
    }
    
    
}



extension LoginViewController : LoginProtocol {
    
    func successEvent() {
        let view = self.storyboard?.instantiateViewController(identifier: "MainViewController") as! MainViewController
        view.modalPresentationStyle = .fullScreen
        self.present(view, animated: false, completion: nil)
        
    }
    
    func failedEvent(_ error: String) {
        
        let alert = UIAlertController(title: nil, message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
