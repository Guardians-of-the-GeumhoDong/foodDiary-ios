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
        let param = CreatePostModel().getCreatePostParam(title: title, rating: rating, createTime: creatTime, memo: memo, images: images)
        let header = dto.getHeader()
        
        // 이미지 업로드 하는 방법 AF.Upload
        AF.request(dto.getResisterPath(), method: .post, parameters: param, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            
            do {
            switch response.result {
            case .success(let value):
                
                let json = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                let data = try JSONDecoder().decode(CreatePost.self, from: json)
                
                if data.alert == nil {
                self.successCreatePost()
                } else {
                    self.failedCreatPost("포스트 생성 실패")
                }
                break
            case .failure:
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
        print("포스트 생성 실패 \(error)")
        
        self.delegate?.failedEvent(error)
    }
    
}
