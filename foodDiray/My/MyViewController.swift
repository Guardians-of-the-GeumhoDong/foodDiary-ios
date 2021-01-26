//
//  MyViewController.swift
//  foodDiray
//
//  Created by Suhong Jeong on 2021/01/26.
//

import UIKit

class MyViewController : UIViewController {
    
    
    @IBAction func logout(_ sender: UIButton) {
        LoginViewModel().logout()
        
        let view = storyboard?.instantiateViewController(identifier: "LoginViewController") as! LoginViewController
        view.modalPresentationStyle = .fullScreen
        self.present(view, animated: false, completion: nil)
    }
}
