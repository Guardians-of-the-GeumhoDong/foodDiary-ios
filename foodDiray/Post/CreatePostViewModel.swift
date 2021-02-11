//
//  PostEditViewModel.swift
//  foodDiray
//
//  Created by Suhong Jeong on 2021/02/03.
//

import Alamofire

protocol CreatePostProtocol {
    func successEvent()
    func failedEvent(_ error: String)
}

class CreatePostViewModel {
    
    var delegate : CreatePostProtocol?


    func createPost(title: String, rating: Int, creatTime: String, memo: String, images: UIImage) {
        
        let dto = NetworkDTO()
        let param = CreatePostModel().getCreatePostParam(title: title, rating: rating, createTime: creatTime, memo: memo)
        let header = dto.getDataHeader()
        
        AF.upload(multipartFormData: { (multipartFormData) in
            
            for (key, value) in param {
                if let data = ("\(value)").data(using: .utf8) {
                    multipartFormData.append(data, withName: key)
                }
            }
            
            let imageData = images.jpegData(compressionQuality: 0.5)
            multipartFormData.append(imageData!, withName: "images[]", fileName: "postImage", mimeType: "image/jpeg")

        }, to: dto.getPostPath(), headers: header).response { (response) in

            do {
            switch response.response?.statusCode {
            case 201, 200:
               self.successCreatePost()
               break
            default:
                self.failedCreatPost("포스트 생성 실패")
                break
            }
            } catch {
                self.failedCreatPost("포스트 생성 실패")
            }
        }
    }
    
    func successCreatePost() {
        self.delegate?.successEvent()
    }
    
    func failedCreatPost(_ error: String) {
        self.delegate?.failedEvent(error)
    }
    
}
