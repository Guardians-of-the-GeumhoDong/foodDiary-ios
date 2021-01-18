//
//  PostEditViewController.swift
//  foodDiray
//
//  Created by Suhong Jeong on 2021/01/14.
//

import UIKit
import SnapKit

class PostEditViewController: UIViewController {

    @IBOutlet weak var photoImage: UIImageView!
    
    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let gesture = UITapGestureRecognizer(target: self, action: #selector(showPhotoAlert))
        photoImage.addGestureRecognizer(gesture)
        photoImage.isUserInteractionEnabled = true
        
        picker.delegate = self
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
        
        photoImage.removeFromSuperview()
        
        let image = UIImage(systemName: "plus.rectangle.fill.on.rectangle.fill")
        photoImage.image = image
        photoImage.backgroundColor = .darkGray
        photoImage.snp.makeConstraints { (m) in
            m.width.equalTo(414)
            m.height.equalTo(516)
        }
        
        
    }

}

extension PostEditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectImage: UIImage? = nil
          
        if let image = info[.editedImage] as? UIImage {
            selectImage = image
        } else if let image = info[.originalImage] as? UIImage {
            selectImage = image
          }
        
        photoImage.backgroundColor = .white
        photoImage.contentMode = .scaleAspectFill
        photoImage.image = selectImage
        
        let deleteButton = UIButton()
        let deleteImage = UIImage(systemName: "xmark.circle.fill")
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
