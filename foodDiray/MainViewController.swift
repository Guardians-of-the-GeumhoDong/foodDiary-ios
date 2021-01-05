//
//  MainViewController.swift
//  foodDiray
//
//  Created by Suhong Jeong on 2021/01/05.
//

import UIKit

class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

  
    }
    

    @IBAction func logout(_ sender: UIButton) {
        
        LoginViewModel().logout()
        
        let view = self.storyboard?.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
        view.modalPresentationStyle = .fullScreen
        self.present(view, animated: false, completion: nil)
    }
    
}
