//
//  MainViewController.swift
//  foodDiray
//
//  Created by Suhong Jeong on 2021/01/12.
//

import UIKit
import Foundation

class TimelineViewController : UIViewController {
    
    let vm = TimelineViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        vm.delegate = self
        vm.loadTimeline()
    }

    
    @IBAction func showPostEdit(_ sender: UIButton) {
        let view = self.storyboard?.instantiateViewController(identifier: "CreatePostViewController") as! CreatePostViewController
        view.modalPresentationStyle = .fullScreen
        self.present(view, animated: false, completion: nil)
    }
}

extension TimelineViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.getPostCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TimelineCell", for: indexPath) as! TimelineTableViewCell
        
        return cell
    }
    
}

extension TimelineViewController : TimelineProtocol {
    func successEvent() {
    }
    
    func failedEvent(_ error: String) {
    }
    
}
