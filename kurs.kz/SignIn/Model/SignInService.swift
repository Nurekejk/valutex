//
//  SignInService.swift
//  kurs.kz
//
//  Created by Акерке on 27.07.2023.
//

import Foundation

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

    func signIn(phone: String,
                password: String,
                completion: @escaping (Result<SignInResponse, NetworkError>) -> Void) {
        guard let urlLogin = URL(string: apiUrlUserLogin) else {
            completion(.failure(.badURL))
            return
        }

        let signInRequest = SignInRequest(phone: phone, password: password)
        var requestLogin = URLRequest(url: urlLogin)
        requestLogin.httpMethod = "POST"
        requestLogin.addValue("application/json", forHTTPHeaderField: "Content-Type")
        requestLogin.addValue("application/json", forHTTPHeaderField: "Accept")

        do {
            requestLogin.httpBody =
            try JSONEncoder().encode(signInRequest)
        } catch {
            completion(.failure(.jsonSerializationError))
            return
        }

        let taskLogin = URLSession.shared.dataTask(with: requestLogin) { data, _, error in
            if let error = error {
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
