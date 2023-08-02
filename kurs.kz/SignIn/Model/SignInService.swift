//
//  SignInService.swift
//  kurs.kz
//
//  Created by Акерке on 27.07.2023.
//

import Foundation
import Alamofire

final class SignInService {
    private let apiUrlUserLogin = "http://77.240.38.143:4443/login"

    // MARK: - Network
    func signIn(phone: String,
                password: String,
                completion: @escaping (Result<SignInResponse, Error>) -> Void) {
        
        var signIn = URLComponents()
        signIn.scheme = "http"
        signIn.host = "77.240.38.143"
        signIn.port = 4443
        signIn.path = "/login"
        
        guard let url = signIn.url else {
            print("error while creating URl")
            return
        }
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        let parameters: Parameters = [
            "grant_type": "",
            "username": phone,
            "password": password,
            "scope": "",
            "client_id": "",
            "client_secret": ""
        ]
        
        AF.request(url, method: .post,
                   parameters: parameters, headers: headers)
        .responseDecodable(of: SignInResponse.self) { data in
            switch data.result {
            case .success(let value):
                completion(.success(value))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
