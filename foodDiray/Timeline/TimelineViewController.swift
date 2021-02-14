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
    var refreshControl : UIRefreshControl?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(updateTableView(controll:)), for: .valueChanged)
        tableView.addSubview(refreshControl!)
        
        tableView.delegate = self
        
        vm.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        vm.loadTimeline()
    }
    
    
    
    @objc func updateTableView(controll: UIRefreshControl) {
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
        cell.selectionStyle = .none
        
        if let data = vm.getPostDataForIndex(indexPath.row) {
            cell.updateCell(data: data)
        }
        
        return cell
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! TimelineTableViewCell
        let view = self.storyboard?.instantiateViewController(identifier: "DetailPostViewController") as! DetailPostViewController
        view.modalPresentationStyle = .fullScreen
        self.present(view, animated: false, completion: nil)
        
        view.loadPost(id: "\(cell.postId!)")
    }
    
}

extension TimelineViewController : TimelineProtocol {
    func successEvent() {
        self.tableView.reloadData()
            refreshControl?.endRefreshing()
    }
    
    func failedEvent(_ error: String) {
    }
    
}

