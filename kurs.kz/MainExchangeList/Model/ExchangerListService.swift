//
//  CurrencyListService.swift
//  kurs.kz
//
//  Created by MacBook on 23.07.2023.
//

import Foundation

struct ExchangerListService {
    private var urlSession = URLSession.shared
    
    let exchangeListURL = "http://77.240.38.143:4443/actual_currency_rates"
    
    func fetchExchangers(currencyCode: String, cityId: Int, completion: @escaping ([MockExchanger]) -> Void) {
        guard let url = URL(string: exchangeListURL) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestData: [String: Any] = ["currency_code": currencyCode, "city_id": cityId]
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestData)
            urlRequest.httpBody = jsonData
        } catch {
            print("Error creating JSON data: \(error)")
            return
        }
        
        let task = urlSession.dataTask(with: urlRequest) { data, _, _ in
            guard let data = data else {
                fatalError("Data not found")
            }
            if let exchangers = parseJSON(excnhagerData: data) {
                DispatchQueue.main.async {
                    completion(exchangers)
                }
            }
        }
        task.resume()
    }
    
    func parseJSON(excnhagerData:Data) -> [MockExchanger]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([MockExchanger].self, from: excnhagerData)
            return decodedData
        } catch {
            print("error:\(error)")
            return nil
        }
    }
}
