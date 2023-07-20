//
//  CurrencySelectorManager.swift
//  kurs.kz
//
//  Created by MacBook on 20.07.2023.
//

import Foundation

struct CurrencySelectorManager {
    let currencyListURL = "http://77.240.38.143:4443/currencies_list"
    var delegate: CurrencySelectorManagerDelegate?
    
    private func fetchCurrencies() {
        let urlsesion = URLSession.shared
        if let url = URL(string: currencyListURL) {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            
            let task = urlsesion.dataTask(with: urlRequest) { data, _, error in
                if error != nil {
                    self.delegate?.didFailWithError(error!)
                    return
                }
                if let safeData = data {
                    if let currency = parseJSON(currencyData: safeData) {
                        DispatchQueue.main.async {
                            self.delegate?.currencyDidUpdate(currency)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(currencyData:Data) -> Currency? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(Currency.self, from: currencyData)
            return decodedData
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
}
