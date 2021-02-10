//
//  TimelineViewModel.swift
//  foodDiray
//
//  Created by Suhong Jeong on 2021/02/10.
//

import Alamofire

protocol TimelineProtocol {
    func successEvent()
    func failedEvent(_ error: String)
}


class TimelineViewModel {
    
    var postsData : TimelineModel?
    
    var delegate : TimelineProtocol?

    
    func loadTimeline() {
        
        let dto = NetworkDTO()
        let header = dto.getDataHeader()
        
        AF.request(dto.getPostPath(), method: .post, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            
            do {
            switch response.result {
            case .success(let value):
                
                let json = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                self.postsData = try JSONDecoder().decode(TimelineModel.self, from: json)
                
                if response.response?.statusCode == 200 {
                self.successLoadTimeline()
                    
                } else {
                    self.failedLoadTimeline("타임라인 불러오기 실패")
                }
                break
                
            case .failure:
                self.failedLoadTimeline("타임라인 불러오기 실패")
                break
            }
                
            } catch {
                self.failedLoadTimeline("타임라인 불러오기 실패")
            }
    }
    }
    
    func successLoadTimeline() {
        self.delegate?.successEvent()
    }
    
    func failedLoadTimeline(_ error: String) {
        self.delegate?.failedEvent(error)
    }
    
    func getPostCount() -> Int {
        
        guard let count = postsData?.posts?.count else {
            return 0
        }
        
        return count
    }
}
