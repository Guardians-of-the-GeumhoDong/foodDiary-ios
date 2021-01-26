//
//  MainViewController.swift
//  foodDiray
//
//  Created by Suhong Jeong on 2021/01/12.
//

import UIKit
import Foundation

class MainViewController : UIViewController {
 
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    @IBAction func showPostEdit(_ sender: UIButton) {
        let view = self.storyboard?.instantiateViewController(identifier: "PostEditViewController") as! PostEditViewController
        self.present(view, animated: false, completion: nil)
    }
}

extension MainViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! MainTableViewCell
        
        return cell
    }
    
}

