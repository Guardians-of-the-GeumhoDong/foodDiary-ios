//
//  DetailPostModel.swift
//  foodDiray
//
//  Created by Suhong Jeong on 2021/02/14.
//


struct DetailPostModel : Decodable {
    
    var id : Int?
    var title : String?
    var rating : Int?
    var createTime : String?
    var description : String?
    var imagesURL : [String]?
    
    enum codingKeys: String, CodingKey {
        case id
        case title
        case rating
        case createTime = "write_at"
        case description
        case imagesURL = "images"
    }
    
    init(from decoder: Decoder) throws {
        let data = try decoder.container(keyedBy: codingKeys.self)
        
        id = try? data.decode(Int.self, forKey: .id)
        title = try? data.decode(String.self, forKey: .title)
        rating = try? data.decode(Int.self, forKey: .rating)
        createTime = try? data.decode(String.self, forKey: .createTime)
        description = try? data.decode(String.self, forKey: .description)
        imagesURL = try? data.decode([String].self, forKey: .imagesURL)
    }
}
