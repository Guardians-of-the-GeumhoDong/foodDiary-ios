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
    func failedEvent()
}

class LoginViewModel {
    

    var delegate : LoginProtocol?
    
    
    
    func loginJTI() {
        
        let dto = NetworkDTO()
        
        if let jti = UserDefaults.standard.object(forKey: "jti") {
            
            let header : HTTPHeaders = [
                "Authorization" : String("Bearer \(jti)"),
                "Accept": "application/json"
            ]
            
            AF.request(dto.getLoginPath(), method: .post, encoding: JSONEncoding.default, headers: header).responseJSON { (response) in
                
                var error : Error?
                
                switch response.result {
                case .success(let value):
                    
                    let json = try! JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                    let data = try! JSONDecoder().decode(Login.self, from: json)

                    UserDefaults.standard.set(data.jti, forKey: "jti")
                    UserDefaults.standard.set(data.email, forKey: "email")
                    
                    self.successLogin()
                    break
                    
                case .failure(let err):
                    error = err
                    break
                }
                
                if error != nil {
                    print(error!.localizedDescription)
                    self.failedLogin()
                }
        }
        }
    }
    
    func login(email: String?, password: String?) {
        
        let dto = NetworkDTO()
        let param = LoginModel().getLoginParam(email: email!, password: password!)
        
        AF.request(dto.getLoginPath(), method: .post, parameters: param, encoding: JSONEncoding.default).responseJSON { (response) in
            
            var error : Error?
            
            switch response.result {
            case .success(let value):
                
                let json = try! JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                let data = try! JSONDecoder().decode(Login.self, from: json)

                UserDefaults.standard.set(data.jti, forKey: "jti")
                UserDefaults.standard.set(data.email, forKey: "email")
            
                self.successLogin()
                break
                
            case .failure(let err):
                error = err
                break
            }
            
            if error != nil {
                print(error!.localizedDescription)
                self.failedLogin()
            }
    }
    }

    func logout() {
        UserDefaults.standard.removeObject(forKey: "jti")
        UserDefaults.standard.removeObject(forKey: "email")
    }
    
    
    func successLogin() {
        self.delegate?.successEvent()
    }
    
    func failedLogin() {
        self.delegate?.failedEvent()
    }
}
