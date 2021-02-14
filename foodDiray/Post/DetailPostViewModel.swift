//
//  DetailPosViewModel.swift
//  foodDiray
//
//  Created by Suhong Jeong on 2021/02/12.
//

import Alamofire

protocol DetailPostProtocol {
    func successEvent(_ data : DetailPostModel)
    func failedEvent(_ error: String)
}

protocol DeletePostProtocol {
    func successEvent()
    func failedEvent(_ error: String)
}


class DetailPostViewModel {
    
    
    var detailDelegate : DetailPostProtocol?
    var deleteDelegate : DeletePostProtocol?


    func loadPost(id : String) {
        
        let dto = NetworkDTO()
        let header = dto.getDataHeader()
        
        AF.request(dto.getDetailPostURL(id: id), method: .get, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            
            do {
            switch response.response?.statusCode {
            case 200:
                let json = try JSONSerialization.data(withJSONObject: response.value, options: .prettyPrinted)
                let model = try JSONDecoder().decode(DetailPostModel.self, from: json)
                self.successDetailPost(model)
                break
            case 400:
                self.failedDetailPost("존재하지 않는 포스트입니다.")
                break
            default:
                self.failedDetailPost("포스트 불러오기 실패")
                break
            }
                
            } catch {
                self.failedDetailPost("포스트 불러오기 실패")
            }
    }
    }
    
    func deletePost(id : String) {
        
        let dto = NetworkDTO()
        let header = dto.getDataHeader()
        
        AF.request(dto.getDetailPostURL(id: id), method: .delete, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            
            switch response.response?.statusCode {
            case 200:
                self.successDeletePost()
                break
            default:
                self.failedDeletePost("포스트 삭제 실패")
                break
            }
    }
    }
    
    func successDetailPost(_ data : DetailPostModel) {
        self.detailDelegate?.successEvent(data)
    }
    
    func failedDetailPost(_ error: String) {
        self.detailDelegate?.failedEvent(error)
    }
    
    func successDeletePost() {
        self.deleteDelegate?.successEvent()
    }
    
    func failedDeletePost(_ error: String) {
        self.deleteDelegate?.failedEvent(error)
    }
}
