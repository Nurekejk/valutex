//
//  SignUpPageService.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 23.07.2023.
//

import Foundation
import Alamofire

final class OtpRegistrationService {
    
    private var phoneNumber = ""
    private var smsCode = ""
    
    // MARK: - Network
    func postPhoneNumber(with phone: String, completion: @escaping (Result<String, Error>) -> Void) {
        var urlComponent = URLComponents()
        urlComponent.scheme = "http"
        urlComponent.host = "134.122.66.97"
        urlComponent.port = 4443
        urlComponent.path = "/otp/registration"
        
        guard let url = urlComponent.url else {
            return
        }
        
        phoneNumber = phone
        let parameters: [String: Any] = ["phone": phone]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: String.self) { response in
                switch response.result {
                case .success(let message):
                    completion(.success(message))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func postOTPCode (with smsCode: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        var urlComponent = URLComponents()
        urlComponent.scheme = "http"
        urlComponent.host = "134.122.66.97"
        urlComponent.port = 4443
        urlComponent.path = "/otp/verify"
        
        guard let url = urlComponent.url else {
            return
        }
        
        self.smsCode = smsCode
        let parameters: [String: Any] = ["phone": phoneNumber,
                                         "sms_code": smsCode]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: Bool.self) { response in
                switch response.result {
                case .success(let accepted):
                    completion(.success(accepted))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchUser (with user: User, completion: @escaping (Result<SignInResponse, Error>) -> Void) {
        var urlComponent = URLComponents()
        urlComponent.scheme = "http"
        urlComponent.host = "134.122.66.97"
        urlComponent.port = 4443
        urlComponent.path = "/signup"
        
        guard let url = urlComponent.url else {
            return
        }
        
        let parameters: [String: Any] = [ "name": user.name,
                                          "surname": user.surname,
                                          "middle_name": user.middleName,
                                          "password": user.password,
                                          "phone": user.phone,
                                          "device_id": user.deviceID,
                                          "language": user.language,
                                          "currency_code": user.currencyCode,
                                          "city_id": user.cityID,
                                          "sms_code": user.smsCode]
        
        AF.request(url, method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: SignInResponse.self) { response in
                switch response.result {
                case .success(let message):
                    completion(.success(message))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    // MARK: - Public
    public func getPhoneNumber() -> String {
        return phoneNumber
    }
    
    public func getSMSCode() -> String {
        return smsCode
    }
}
