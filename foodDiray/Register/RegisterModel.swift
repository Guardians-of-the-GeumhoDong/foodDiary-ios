//
//  RegisterModel.swift
//  foodDiray
//
//  Created by Suhong Jeong on 2021/01/25.
//

import Alamofire

class RegisterModel {
 
    func getRegisterParam(email: String, name: String, password: String, confirPassword: String) -> Parameters {
        
        let param : Parameters = [
            "email" : email,
            "name" : name,
            "password" : password,
            "password_confirmation" : confirPassword
        ]
        
        return param
    }
    
}

struct Register : Codable {
    var id: Int?
    var email : String?
    var name : String?
    var jti : String?
    
    enum codingKeys: CodingKey {
        case id
        case email
        case name
        case jti
    }
    
    init(from decoder: Decoder) throws {
        let data = try decoder.container(keyedBy: codingKeys.self)
        
        id = try? data.decode(Int.self, forKey: .id)
        email = try? data.decode(String.self, forKey: .email)
        name = try? data.decode(String.self, forKey: .name)
        jti = try? data.decode(String.self, forKey: .jti)
    }
}
