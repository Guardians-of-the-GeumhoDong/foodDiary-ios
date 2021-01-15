//
//  PostEditViewController.swift
//  foodDiray
//
//  Created by Suhong Jeong on 2021/01/14.
//

import UIKit

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
        
          self.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true)
    }
    
}
