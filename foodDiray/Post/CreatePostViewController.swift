//
//  PostEditViewController.swift
//  foodDiray
//
//  Created by Suhong Jeong on 2021/01/14.
//

import UIKit
import SnapKit

class CreatePostViewController: UIViewController {

    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var memoTextView: UITextView!
    
    var vm : CreatePostViewModel?
    
    
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        let gesture = UITapGestureRecognizer(target: self, action: #selector(showPhotoAlert))
        photoImage.addGestureRecognizer(gesture)
        photoImage.isUserInteractionEnabled = true
        
        picker.delegate = self
        
        let formmatter = DateFormatter()
        formmatter.dateFormat = "yyyy-MM-dd"
        dateLabel.text = formmatter.string(from: Date())
        
        memoTextView.delegate = self
        titleTextView.delegate = self
        
        vm = CreatePostViewModel()
        vm?.delegate = self
    }
    
    @objc func showPhotoAlert() {
        
        let alert = UIAlertController(title: "사진 선택", message: nil, preferredStyle: .actionSheet)
        let albumAction = UIAlertAction(title: "앨범", style: .default) { (action) in
            self.picker.modalPresentationStyle = .fullScreen
            self.present(self.picker, animated: true, completion: nil)
        }
        let cameraAction = UIAlertAction(title: "카메라", style: .default, handler: nil)
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alert.addAction(albumAction)
        alert.addAction(cameraAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func unselectPhoto() {

        photoImage.viewWithTag(99)?.removeFromSuperview()
        
        let image = UIImage(systemName: "plus.rectangle.fill.on.rectangle.fill")
        photoImage.image = image
        photoImage.backgroundColor = .darkGray
        photoImage.contentMode = .center
        photoImage.snp.makeConstraints { (m) in
            m.width.equalTo(414)
            m.height.equalTo(516)
        }
        
        for gesture in photoImage.gestureRecognizers! {
            gesture.isEnabled = true
        }
        
        
    }
    
    func close() {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func creatPost(_ sender: UIButton) {
        vm?.createPost(title: titleTextView.text, rating: 1, creatTime: dateLabel.text! , memo: memoTextView.text, images: photoImage.image!)
    }
    
    @IBAction func close(_ sender: UIButton) {
        self.close()
    }
}

extension CreatePostViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectImage: UIImage? = nil
          
        if let image = info[.originalImage] as? UIImage {
            selectImage = image
          }
        
        photoImage.backgroundColor = .white
        photoImage.contentMode = .scaleAspectFill
        photoImage.image = selectImage
        for gesture in photoImage.gestureRecognizers! {
            gesture.isEnabled = false
        }
        
        let deleteButton = UIButton()
        let deleteImage = UIImage(systemName: "xmark.circle.fill")
        deleteButton.tag = 99
        deleteButton.setImage(deleteImage, for: .normal)
        photoImage.addSubview(deleteButton)
        deleteButton.snp.makeConstraints { (m) in
            m.right.equalTo(photoImage).offset(-20)
            m.top.equalTo(photoImage).offset(50)
            m.width.height.equalTo(30)
        }
        
        deleteButton.addTarget(self, action: #selector(unselectPhoto), for: .touchUpInside)
        
        
          self.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true)
    }
    
}

extension CreatePostViewController : UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView == memoTextView && textView.text == "내용을 입력해주세요" {
            textView.text = nil
            textView.textColor = .black
        }
        
        if textView == titleTextView && textView.text == "제목을 입력해주세요" {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView == memoTextView && textView.text.isEmpty {
            textView.text = "내용을 입력해주세요"
            textView.textColor = .lightGray
        }
        
        if textView == titleTextView && textView.text.isEmpty {
            textView.text = "제목을 입력해주세요"
            textView.textColor = .lightGray
        }
    }
    
}

extension CreatePostViewController : CreatePostProtocol {
    
    func successEvent() {
        self.close()
    }
    
    func failedEvent(_ error: String) {
        self.close()
    }
    
    
}
