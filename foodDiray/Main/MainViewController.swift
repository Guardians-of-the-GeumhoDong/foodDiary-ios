//
//  MainViewController.swift
//  foodDiray
//
//  Created by Suhong Jeong on 2021/01/12.
//

import UIKit
import Foundation

class MainViewController : UITableViewController {
 
    var floatingButton : UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createFloatingButton()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! MainTableViewCell
        
        return cell
    }
    
    
    private func createFloatingButton() {
        floatingButton = UIButton(type: .custom)
        floatingButton?.backgroundColor = .clear
        floatingButton?.translatesAutoresizingMaskIntoConstraints = false
        self.constrainFloatingButtonToWindow()
        floatingButton?.setImage(UIImage(named: "floatButton"), for: .normal)
   //     floatingButton?.addTarget(self, action: #selector(doThisWhenButtonIsTapped(_:)), for: .touchUpInside)
    }

    private func constrainFloatingButtonToWindow() {
        DispatchQueue.main.async {
            guard let keyWindow = UIApplication.shared.keyWindow,
                let floatingButton = self.floatingButton else { return }
            keyWindow.addSubview(floatingButton)
            
            // 
//            keyWindow.trailingAnchor.constraint(equalTo: floatingButton.trailingAnchor,
//                                                constant: Constants.trailingValue).isActive = true
//            keyWindow.bottomAnchor.constraint(equalTo: floatingButton.bottomAnchor,
//                                              constant: Constants.leadingValue).isActive = true
//            floatingButton.widthAnchor.constraint(equalToConstant:
//                Constants.buttonWidth).isActive = true
//            floatingButton.heightAnchor.constraint(equalToConstant:
//                Constants.buttonHeight).isActive = true
        }
    }
}

