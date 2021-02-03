//
//  CreatePostModel.swift
//  foodDiray
//
//  Created by Suhong Jeong on 2021/02/03.
//

import Alamofire

class CreatePostModel {
 
    func getCreatePostParam(title: String, rating: Int, createTime: String, memo: String, images: UIImage) -> Parameters {
        
        let param : Parameters = [
            "title" : title,
            "rating" : rating,
            "write_at" : createTime,
            "description" : memo,
            "images[]": images
        ]
        
        return param
    }
    
}

struct CreatePost : Codable {
    var id : Int?
    
    var alert : String?
    
    enum codingKeys: CodingKey {
        case id
        case alert
    }
    
    init(from decoder: Decoder) throws {
        let data = try decoder.container(keyedBy: codingKeys.self)
        
        id = try? data.decode(Int.self, forKey: .id)
        
        alert = try? data.decode(String.self, forKey: .alert)
    }
}

