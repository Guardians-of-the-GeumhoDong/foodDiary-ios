//
//  DetailPostViewController.swift
//  foodDiray
//
//  Created by Suhong Jeong on 2021/02/12.
//

import UIKit
import Kingfisher

class DetailPostViewController : UIViewController {
    
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var memoTextView: UITextView!
    
    var vm : DetailPostViewModel?
    
    func loadPost(id : String) {
        vm = DetailPostViewModel()
        vm?.delegate = self
        
        vm?.loadPost(id: id)
    }
    
    func setPostUI(_ data : DetailPostModel) {
        
        let url = URL(string: NetworkDTO().getImageURL(url: data.imagesURL![0]))
        photoImage.kf.setImage(with: url)
        dateLabel.text = data.createTime
        titleTextView.text = data.title
        memoTextView.text = data.description
        
        
    }
    
    @IBAction func showOption(_ sender: UIButton) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let fixAction = UIAlertAction(title: "수정", style: .default, handler: nil)
        let deleteAction = UIAlertAction(title: "삭제", style: .cancel) { (action) in
            
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(fixAction)
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func closeVC(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}

extension DetailPostViewController : DetailPostProtocol {
    
    func successEvent(_ data: DetailPostModel) {
        setPostUI(data)
    }
    
    func failedEvent(_ error: String) {
        dismiss(animated: true, completion: nil)
    }
}
