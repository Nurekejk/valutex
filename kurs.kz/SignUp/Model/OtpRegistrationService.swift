//
//  SignUpPageService.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 23.07.2023.
//

import Foundation

final class OtpRegistrationService {
    
    private let otpRegistrationURL = "http://77.240.38.143:4443/otp/registration"
    private let otpVerifyURL = "http://77.240.38.143:4443/otp/verify"
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
    
    func postOTPCode (with smsCode: String, completion: @escaping (Result<String, NetworkError>) -> Void) {
        guard let url = URL(string: otpVerifyURL) else {
            completion(.failure(.badURL))
            return
        }
        
        self.smsCode = smsCode
        let parameters: [String: Any] = ["phone": phoneNumber,
                                         "sms_code": smsCode]
        
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
}
