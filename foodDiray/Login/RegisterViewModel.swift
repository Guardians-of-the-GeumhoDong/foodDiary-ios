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

        // 에러처리
        if !isValidEmail(email) {
            self.failedRegister("잘못된 이메일 형식입니다.")
            return
        } else if password != confirPassword || password.isEmpty || confirPassword.isEmpty {
            self.failedRegister("비밀번호를 다시 입력해주시기 바랍니다.")
return
        } else if name.isEmpty {
            self.failedRegister("이름에 공백이 들어갈 수 없습니다.")
            return
        }
        
        let dto = NetworkDTO()
        let param = RegisterModel().getRegisterParam(email: email, name: name, password: password, confirPassword: confirPassword)
        
        AF.request(dto.getResisterPath(), method: .post, parameters: param, encoding: JSONEncoding.default).responseJSON { (response) in
            
            do {
            switch response.result {
            case .success(let value):
                
                let json = try JSONSerialization.data(withJSONObject: value, options: .prettyPrinted)
                let data = try JSONDecoder().decode(Register.self, from: json)
                
                if response.response?.statusCode == 200 {
                self.successRegister(data)
                    
                } else if data.emailError != nil {
                    self.failedRegister("이미 존재하는 이메일 주소입니다.")
                } else {
                    self.failedRegister("회원가입 실패")
                }
                break
                
            case .failure:
                self.failedRegister("회원가입 실패")
                break
            }
                
            } catch {
                self.failedRegister("회원가입 실패")
            }
    }
        }
    
    func successRegister(_ data: Register) {
    
    UserDefaults.standard.set(data.jti, forKey: "jti")
    UserDefaults.standard.set(data.email, forKey: "email")

    self.delegate?.successEvent()
}
    
    func isValidEmail(_ email: String) -> Bool {
          let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
          let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
          return emailTest.evaluate(with: email)
           }

func failedRegister(_ error: String) {
    self.delegate?.failedEvent(error)
}
}
