//
//  CurrencySelectorListService.swift
//  kurs.kz
//
//  Created by MacBook on 20.07.2023.
//

import Foundation

<<<<<<<< HEAD:kurs.kz/Currency/Model/CurrencySelectorListService.swift
struct CurrencySelectorListService {

    weak var delegate: CurrencySelectorListServiceDelegate?
========
struct CurrencyListService {
    let currencyListURL = "http://77.240.38.143:4443/currencies_list"
    weak var delegate: CurrencySelectorManagerDelegate?
>>>>>>>> develop:kurs.kz/Currency/Model/CurrencyListService.swift
    
    func fetchCurrencies() {
        
        var currencyListURLComponent = URLComponents()
        currencyListURLComponent.scheme = "http"
        currencyListURLComponent.host = "77.240.38.143"
        currencyListURLComponent.port = 4443
        currencyListURLComponent.path = "/currencies_list"
        let urlsesion = URLSession.shared
        
        guard let url = currencyListURLComponent.url else {
            return
        }
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
    
    func parseJSON(currencyData:Data) -> [Currency]? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode([Currency].self, from: currencyData)
            return decodedData
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
}
