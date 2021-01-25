//
//  RegisterViewController.swift
//  foodDiray
//
//  Created by Suhong Jeong on 2021/01/25.
//

import UIKit

class RegisterViewController : UIViewController {
    
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var confirPasswordText: UITextField!
    
    var vm : RegisterViewModel?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        vm = RegisterViewModel()
        vm?.delegate = self
    }

    override func viewWillDisappear(_ animated: Bool) {
        vm?.delegate = nil
        vm = nil
    }
    
    @IBAction func startRegister(_ sender: UIButton) {
        vm?.register(email: emailText.text!, name: nameText.text!, password: passwordText.text!, confirPassword: confirPasswordText.text!)
    }
    
    @IBAction func closeView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension RegisterViewController : RegisterProtocol {
    
    func successEvent() { 
        self.dismiss(animated: true, completion: nil)
    }
    
    func failedEvent(_ error: String) {
        
        let alert = UIAlertController(title: nil, message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
