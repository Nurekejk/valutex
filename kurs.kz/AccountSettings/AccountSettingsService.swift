//
//  AccountSettingsService.swift
//  kurs.kz
//
//  Created by MacBook on 21.10.2023.
//

import UIKit
import Alamofire

struct AccountSettingsService {
    
    func updatePassword(newPassword: String,
                        completion: @escaping (Result<[String : String], AFError>) -> Void) {
        print(newPassword)
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "api.valutex.kz"
        urlComponent.path = "/users/update_password"
        
        guard let url = urlComponent.url else {
            return
        }
        
        var headers: HTTPHeaders = [
            "accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        getAuth(&headers)
        let parameters: [String: Any] = ["password": "newPassword"]
        
        AF.request(url, method: .put,
                   parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        .validate()
        .responseDecodable(of: [String : String].self) { response in
            switch response.result {
            case .success(let message):
                completion(.success(message))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func updateUserInfo(newName: String,
                        newMiddleName: String,
                        newSurname: String,
                        completion: @escaping (Result<[String : String], AFError>) -> Void) {
        
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "api.valutex.kz"
        urlComponent.path = "/users/update_settings"
        
        guard let url = urlComponent.url else {
            return
        }
        
        var headers: HTTPHeaders = [
            "accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        getAuth(&headers)
        let parameters: [String: Any] = ["name": newName,
                                         "surname": newSurname,
                                         "middle_name": newMiddleName]
        
        AF.request(url, method: .put,
                   parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        .validate()
        .responseDecodable(of: [String : String].self) { response in
            switch response.result {
            case .success(let message):
                completion(.success(message))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getAuth(_ headers: inout HTTPHeaders) {
        let defaults = UserDefaults.standard
        if let data = defaults.data(forKey: SignInViewController.defaultsUserAndTokensKey) {
            do {
                let tokens = try JSONDecoder().decode(SignInResponse.self, from: data)
                if let accessToken = tokens.access_token {
                    headers["Authorization"] = "Bearer \(accessToken)"
                }
            } catch {
                print("error while decoding")
            }
        }
    }
}
