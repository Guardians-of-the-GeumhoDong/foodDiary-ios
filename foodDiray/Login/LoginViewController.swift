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

    @IBAction func loginEvent(_ sender: UIButton) {
        vm?.login(email: emailText.text, password: passwordText.text)
    }
}



extension LoginViewController : LoginProtocol {
    
    func successEvent() {
        let view = self.storyboard?.instantiateViewController(identifier: "MainViewController") as! MainViewController
        view.modalPresentationStyle = .fullScreen
        self.present(view, animated: false, completion: nil)
        
    }
    
    func failedEvent() {
        
        var message : String?
        
        let alert = UIAlertController(title: "로그인 실패", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
}
