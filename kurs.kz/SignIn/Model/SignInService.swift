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

    enum NetworkError: Error {
        case badURL
        case jsonSerializationError
        case postRequestError
        case nilData
        case decodingError
    }

    // MARK: - Network
    func signIn2(phone: String,
                 password: String,
                 completion: @escaping (Result<SignInResponse, NetworkError>) -> Void) {
        
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
            case .failure:
                completion(.failure(.postRequestError))
            }
        }
    }
    
    func signIn(phone: String,
                password: String,
                completion: @escaping (Result<SignInResponse, NetworkError>) -> Void) {
        guard let urlLogin = URL(string: apiUrlUserLogin) else {
            completion(.failure(.badURL))
            return
        }

        let signInRequest = SignInRequest(username: phone, password: password)
        var requestLogin = URLRequest(url: urlLogin)
        requestLogin.httpMethod = "POST"
        requestLogin.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        requestLogin.addValue("application/json", forHTTPHeaderField: "Accept")

        let parameters: [String: String] = [
            "grant_type": "",
            "username": phone,
            "password": password,
            "scope": "",
            "client_id": "",
            "client_secret": ""
        ]

        do {
            requestLogin.httpBody = try
            JSONSerialization.data(withJSONObject: parameters, options: .fragmentsAllowed)
        } catch {
            completion(.failure(.jsonSerializationError))
            return
        }
//
//        do {
//            try JSONEncoder().encode(signInRequest)
//        } catch {
//            completion(.failure(.jsonSerializationError))
//            return
//        }

        let taskLogin = URLSession.shared.dataTask(with: requestLogin) { data, _, error in
            if let error = error {
                print(error)
                completion(.failure(.postRequestError))
                return
            }
            guard let responseData = data else {
                completion(.failure(.nilData))
                return
            }
            do {
                let decodedData = try
                    JSONDecoder().decode(SignInResponse.self, from: responseData)
                DispatchQueue.main.async {
                    completion(.success(decodedData))
                }
            } catch let error {
                print(error)
                completion(.failure(.decodingError))
                return
            }
        }
        taskLogin.resume()
    }
}
