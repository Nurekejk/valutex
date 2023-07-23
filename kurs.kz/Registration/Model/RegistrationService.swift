//
//  RegistrationService.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 23.07.2023.
//

import Foundation

final class RegistrationService {
    
    // MARK: - Network
    func fetchUser(with user: FullUser, completion: @escaping (String) -> Void) {
        guard let url = URL(string: "http://77.240.38.143:4443/signup") else { fatalError() }
        
        let parameters: [String: Any] = ["name": user.name,
                                         "surname": user.surname,
                                         "middle_name": user.middleName,
                                         "password": user.password,
                                         "phone": user.phone,
                                         "device_id": user.deviceID,
                                         "language": user.language,
                                         "currency_code": user.currencyCode,
                                         "city_id": user.cityID,
                                         "sms_code": user.smsCode]
        
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
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                print("Post Request Error: \(error.localizedDescription)")
                return
            }
            
            guard let responseData = data else {
                print("nil Data received from the server")
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(String.self, from: responseData)
                DispatchQueue.main.async {
                    completion(decodedData)
                }
            } catch {
                print("Data decoded incorrectly.")
                return
            }
        }
        
        task.resume()
    }
}
