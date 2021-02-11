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
    
    var postsData = [TimelineModel]()
    
    var delegate : TimelineProtocol?

    
    func loadTimeline() {
        
        let dto = NetworkDTO()
        let header = dto.getDataHeader()
        
        AF.request(dto.getPostPath(), method: .get, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
            
            do {
            switch response.response?.statusCode {
            case 200:
                let json = try JSONSerialization.data(withJSONObject: response.value, options: .prettyPrinted)
                let model = try JSONDecoder().decode([TimelineModel].self, from: json)
                self.postsData = model
                self.successLoadTimeline()
            default:
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
        return postsData.count
    }
    
    func getPostDataForIndex(_ index : Int) -> TimelineModel? {
        return postsData[index] ?? nil
    }
}
