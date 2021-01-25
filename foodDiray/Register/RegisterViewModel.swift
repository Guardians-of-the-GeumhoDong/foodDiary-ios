//
//  RegisterViewModel.swift
//  foodDiray
//
//  Created by Suhong Jeong on 2021/01/25.
//

import Alamofire

protocol RegisterProtocol {
    func successEvent()
    func failedEvent(_ error: String)
}

class RegisterViewModel {
    
    var delegate : RegisterProtocol?
    
    
    func register(email: String, name: String, password: String, confirPassword: String) {
        
        let dto = NetworkDTO()
        let param = RegisterModel().getRegisterParam(email: email, name: name, password: password, confirPassword: confirPassword)
        
        AF.request(dto.getResisterPath(), method: .post, parameters: param, encoding: JSONEncoding.default).responseJSON { (response) in
            
            do {
            switch response.result {
            case .success(let value):
                
                let json = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                let data = try JSONDecoder().decode(Register.self, from: json)

                if data.id != nil {
                self.successRegister(data)
                    
                } else {
                    self.failedRegister("회원가입 실패 \(response.error)")
                }
                break
                
            case .failure:
                self.failedRegister("회원가입 실패 \(response.error)")
                break
            }
                
            } catch {
                self.failedRegister("회원가입 실패 \(response.error)")
            }
    }
        }
    
    func successRegister(_ data: Register) {
    
    UserDefaults.standard.set(data.jti, forKey: "jti")
    UserDefaults.standard.set(data.email, forKey: "email")

    self.delegate?.successEvent()
}

func failedRegister(_ error: String) {
    self.delegate?.failedEvent(error)
}
}
