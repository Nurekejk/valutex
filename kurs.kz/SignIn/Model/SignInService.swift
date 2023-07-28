//
//  SignInService.swift
//  kurs.kz
//
//  Created by Акерке on 27.07.2023.
//

import Foundation

final class SignInService {

    private let apiUrlUserCheck = "http://77.240.38.143:4443/user/check"
    private let apiUrlUserLogin = "http://77.240.38.143:4443/login"

    enum NetworkError: Error {
        case badURL
        case jsonSerializationError
        case postRequestError
        case nilData
        case decodingError
    }

    // MARK: - Network

    func postSignInData(phone: String, password: String, completion: @escaping (Result<String, NetworkError>) -> Void) {

        // URL for user check

        guard let urlCheck = URL(string: apiUrlUserCheck) else {
            completion(.failure(.badURL))
            return
        }
        guard let urlLogin = URL(string: apiUrlUserLogin) else {
            completion(.failure(.badURL))
            return
        }

        // Request body for user check

        let requestBodyCheck: [String: String] = ["phone": phone]
//        let requestBodyLogin: [String: String] = ["phone": phone]
        var requestCheck = URLRequest(url: urlCheck)
        requestCheck.httpMethod = "POST"
        requestCheck.addValue("application/json", forHTTPHeaderField: "Content-Type")
        requestCheck.addValue("application/json", forHTTPHeaderField: "accept")

        do {
            requestCheck.httpBody = try
            JSONSerialization.data(withJSONObject: requestBodyCheck, options: .fragmentsAllowed)
        } catch {
            completion(.failure(.jsonSerializationError))
            return
        }

        // Request body for user login

        let requestBodyLogin: [String: String] = ["phone": phone, "password": password]
        var requestLogin = URLRequest(url: urlLogin)
        requestLogin.httpMethod = "POST"
        requestLogin.addValue("application/json", forHTTPHeaderField: "Content-Type")
        requestLogin.addValue("application/json", forHTTPHeaderField: "accept")

        do {
            requestLogin.httpBody = try JSONSerialization.data(withJSONObject: requestBodyLogin, options: .fragmentsAllowed)
        } catch {
            completion(.failure(.jsonSerializationError))
            return
        }
        
        let taskLogin = URLSession.shared.dataTask(with: requestLogin) { data, _, error in
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
                let decodedData = try
                JSONDecoder().decode(String.self, from:
                                        responseData)
                DispatchQueue.main.async {
                    completion(.success(decodedData))
                }
            } catch {
                completion(.failure(.decodingError))
                return
            }
        }
        taskLogin.resume()
    }
}
