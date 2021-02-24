//
//  LoginViewController.swift
//  Lamoti
//
//  Created by Suhong Jeong on 2020/10/29.
//

import UIKit
import AVFoundation
import Kingfisher

class LoginViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var loginButton: UIButton!

    private var vm : LoginViewModel?
    var player : AVPlayer?

    override func viewDidLoad() {
        vm = LoginViewModel()
        vm?.delegate = self
    
        self.loginJTI()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerItemDidReachEnd(notification:)),
                                               name: Notification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: player?.currentItem)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.setSplash()
    }

    
    func loginJTI() {
        vm?.loginJTI()
    }
    
    func setSplash() {

        if let url = Bundle.main.url(forResource: "splash_2", withExtension: "mp4") {
            
            let layer = AVPlayerLayer()
            player = AVPlayer(url: url)
            layer.player = player
            layer.frame = self.view.bounds
            layer.videoGravity = .resizeAspectFill
            layer.opacity = 0.8
            self.view.layer.insertSublayer(layer, at: 0)
            player?.play()
    }
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
    
    @objc func playerItemDidReachEnd(notification: Notification) {
           if let playerItem: AVPlayerItem = notification.object as? AVPlayerItem {
            playerItem.seek(to: CMTime.zero, completionHandler: nil)
            self.player?.play()
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
        let view = self.storyboard?.instantiateViewController(identifier: "MainTabBarViewController") as! UITabBarController
        view.modalPresentationStyle = .fullScreen
        self.present(view, animated: false, completion: nil)
        
    }
    
    func failedEvent(_ error: String) {
        
        let alert = UIAlertController(title: nil, message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
