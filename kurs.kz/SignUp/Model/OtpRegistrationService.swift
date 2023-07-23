//
//  SignUpPageService.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 23.07.2023.
//

import Foundation

final class SignUpPageService {
    
    // MARK: - Network
    func postOTPRequest(with user: User) {
        guard let url = URL(string: "http://77.240.38.143:4443/otp/registration") else { fatalError() }
        
        let parameters: [String: Any] = ["phone": user.phone]
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "accept")
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters,
                                                          options: .fragmentsAllowed)
        } catch let error {
            print(error.localizedDescription)
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Post Request Error: \(error.localizedDescription)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse,
               !(200...299).contains(httpResponse.statusCode) {
                print("Invalid Response received from the server")
            }
            
            guard let responseData = data else {
                print("nil Data received from the server")
                return
            }
            
            print(String(data: responseData, encoding: .utf8) as Any)
        }
        
        task.resume()
    }
}
