//
//  SignUpPageService.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 23.07.2023.
//

import Foundation
import Alamofire

final class OtpRegistrationService {
    
    private let otpRegistrationURL = "http://77.240.38.143:4443/otp/registration"
    private let otpVerifyURL = "http://77.240.38.143:4443/otp/verify"
    private let signUpURL = "http://77.240.38.143:4443/signup"
    private var phoneNumber = ""
    private var smsCode = ""
    
    enum NetworkError: Error {
        case badURL
        case jsonSerializationError
        case postRequestError
        case nilData
        case decodingError
    }
    
    // MARK: - Network
    func postPhoneNumber(with phone: String, completion: @escaping (Result<String, NetworkError>) -> Void) {
        guard let url = URL(string: otpRegistrationURL) else {
            completion(.failure(.badURL))
            return
        }
        
        phoneNumber = phone
        let parameters: [String: Any] = ["phone": phone]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "accept")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters,
                                                          options: .fragmentsAllowed)
        } catch {
            completion(.failure(.jsonSerializationError))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Post Request Error: \(error.localizedDescription)")
                completion(.failure(.postRequestError))
                return
            }
            
            guard let responseData = data else {
                print("nil Data received from the server")
                completion(.failure(.nilData))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(String.self, from: responseData)
                DispatchQueue.main.async {
                    completion(.success(decodedData))
                }
            } catch {
                completion(.failure(.decodingError))
                return
            }
        }
        
        task.resume()
    }
    
    func postPhoneNumber(with phone: String, completion: @escaping (Result<String, Error>) -> Void) {
    }
    
    func postOTPCode (with smsCode: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        self.smsCode = smsCode
        let parameters: [String: Any] = ["phone": phoneNumber,
                                         "sms_code": smsCode]
        
        AF.request(otpVerifyURL, method: .post, parameters: parameters, encoding: JSONEncoding.default)
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

    func fetchUser (with user: User, completion: @escaping (Result<String, Error>) -> Void) {
        
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
                                          
        AF.request(signUpURL, method: .post, parameters: parameters, encoding: JSONEncoding.default)
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
    
    // MARK: - Public
    public func getPhoneNumber() -> String {
        return phoneNumber
    }
    
    public func getSMSCode() -> String {
        return smsCode
    }
}
