//
//  OfferSellManager.swift
//  kurs.kz
//
//  Created by MacBook on 20.07.2023.
//

import Foundation

struct OfferSellManager {
    let currencyListURL = "http://77.240.38.143:4443/currencies_list"
    var OfferSellManagerDelegate: OfferSellManagerDelegate?
    
    private func fetchCurrencies() {
        let urlsesion = URLSession.shared
        if let url = URL(string: currencyListURL) {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            
            let task = urlsesion.dataTask(with: urlRequest) { data, _, error in
                if error != nil {
                    self.OfferSellManagerDelegate?.didFailWithError(error!)
                    return
                }
                if let safeData = data {
                    if let currency = parseJSON(currencyData: safeData) {
                        DispatchQueue.main.async {
                            self.OfferSellManagerDelegate?.currencyDidUpdate(currency)
                        }
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(currencyData:Data) -> OfferSellCurrency? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(OfferSellCurrency.self, from: currencyData)
            return decodedData
        } catch {
            OfferSellManagerDelegate?.didFailWithError(error)
            return nil
        }
    }
}
