//
//  NetworkDTO.swift
//  foodDiray
//
//  Created by Suhong Jeong on 2020/12/31.
//

import Alamofire

class NetworkDTO {
    
    private final let baseURL = "https://food-diary-dev.herokuapp.com/"
    
    private final let loginURL = "login"
    private final let registerURL = "register"
    private final let postURL = "v1/posts"
    
    func getJSONHeader() -> HTTPHeaders? {
        
        if let jti = UserDefaults.standard.object(forKey: "jti") {
        return HTTPHeaders([
            "Authorization" : String("Bearer \(jti)"),
            "Accept": "application/json"
        ])
        } else {
            return nil
        }
    }
    
    func getDataHeader() -> HTTPHeaders? {
        
        if let jti = UserDefaults.standard.object(forKey: "jti") {
        return HTTPHeaders([
            "Authorization" : String("Bearer \(jti)"),
            "Accept": "multipart/form-data"
        ])
        } else {
            return nil
        }
    }
    
    func getLoginPath() -> String {
        return String("\(self.baseURL)\(self.loginURL)")
    }
    
    func getResisterPath() -> String {
        return String("\(self.baseURL)\(self.registerURL)")
    }
    
    func getPostPath() -> String {
        return String("\(self.baseURL)\(self.postURL)")
    }
    
}
