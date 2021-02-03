//
//  LoginView.swift
//  Lamoti
//
//  Created by Suhong Jeong on 2020/12/22.
//


import Alamofire
import Security


protocol LoginProtocol {
    func successEvent()
    func failedEvent(_ error: String)
}

class LoginViewModel {
    

    var delegate : LoginProtocol?
    
    
    
    func loginJTI() {
        
        let dto = NetworkDTO()
    
        if let header = dto.getHeader() {
            
            AF.request(dto.getLoginPath(), method: .post, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
                
                do {
                switch response.result {
                case .success(let value):
                    
                    let json = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    let data = try JSONDecoder().decode(Login.self, from: json)

                    if data.alert == nil {
                    self.successLogin(data)
                        
                    } else {
                        self.failedLogin("로그인 실패")
                    }
                    break
                    
                case .failure:
                    self.failedLogin("로그인 실패")
                    break
                }
                    
                } catch {
                    self.failedLogin("로그인 실패")
                }
        }
        }
    }
    
    func login(email: String?, password: String?) {
        
        let dto = NetworkDTO()
        let param = LoginModel().getLoginParam(email: email!, password: password!)
        
        AF.request(dto.getLoginPath(), method: .post, parameters: param, encoding: JSONEncoding.default).responseJSON { (response) in
            
            do {
            switch response.result {
            case .success(let value):
                
                let json = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                let data = try JSONDecoder().decode(Login.self, from: json)
                
                if data.alert == nil {
                self.successLogin(data)
                } else {
                    self.failedLogin("로그인 실패")
                }
                break
            case .failure:
                self.failedLogin("로그인 실패")
                break
            }
            } catch {
                self.failedLogin("로그인 실패")
            }
    }
    }

    func logout() {
        UserDefaults.standard.removeObject(forKey: "jti")
        UserDefaults.standard.removeObject(forKey: "email")
    }
    
    
    func successLogin(_ data: Login) {
        
        UserDefaults.standard.set(data.jti, forKey: "jti")
        UserDefaults.standard.set(data.email, forKey: "email")
    
        self.delegate?.successEvent()
    }
    
    func failedLogin(_ error: String) {
        self.delegate?.failedEvent(error)
    }
}
