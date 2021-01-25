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
    
    
    func getLoginPath() -> String {
        return String("\(self.baseURL)\(self.loginURL)")
    }
    
    func getResisterPath() -> String {
        return String("\(self.baseURL)\(self.registerURL)")
    }
    
}
