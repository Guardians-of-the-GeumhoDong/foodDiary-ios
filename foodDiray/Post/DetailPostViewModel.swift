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


class DetailPostViewModel {
    
    
    var delegate : DetailPostProtocol?


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
                self.failedDetailPost("타임라인 불러오기 실패")
                break
            }
                
            } catch {
                self.failedDetailPost("포스트 불러오기 실패")
            }
    }
    }
    
    func successDetailPost(_ data : DetailPostModel) {
        self.delegate?.successEvent(data)
    }
    
    func failedDetailPost(_ error: String) {
        self.delegate?.failedEvent(error)
    }
    
}
