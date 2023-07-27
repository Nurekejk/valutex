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
        let requestBody: [String: String] = ["phone": phone]
        let requestBodyLogin: [String: String] = ["phone": phone]

        var request = URLRequest(url: urlCheck)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "accept")

        do {
            request.httpBody = try
            JSONSerialization.data(withJSONObject: requestBody, options: .fragmentsAllowed)
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
        task.resume()
    }


}
