//
//  LoginModel.swift
//  foodDiray
//
//  Created by Suhong Jeong on 2021/01/04.
//

import Alamofire

class LoginModel {

    func getLoginParam(email: String, password: String) -> Parameters {
        
        let param : Parameters = [
            "email" : email,
            "password" : password
        ]
        
        return param
    }
}

struct Login : Codable {
    var email: String?
    var jti : String?
    var alert : String?
    
    enum codingKeys: CodingKey {
        case email
        case jti
        case alert
    }
    
    init(from decoder: Decoder) throws {
        let data = try decoder.container(keyedBy: codingKeys.self)
        
        email = try? data.decode(String.self, forKey: .email)
        jti = try? data.decode(String.self, forKey: .jti)
        alert = try? data.decode(String.self, forKey: .alert)
    }
}
