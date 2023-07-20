//
//  OfferSellManager.swift
//  kurs.kz
//
//  Created by MacBook on 20.07.2023.
//

import Foundation

struct OfferSellManager {
    let currencyListURL = "http://77.240.38.143:4443/currencies_list"
    var OfferSellManagerDelegate: OfferSellManagerDelegate
    
    private func fetchCurrencies() {
        let urlsesion = URLSession.shared
        if let url = URL(string: currencyListURL) {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"

            let task = urlsesion.dataTask(with: urlRequest) { data, _, error in
                if let data = data {
                    do {
                        
                        DispatchQueue.main.async {
                            self.OfferSellManagerDelegate.currencyDidUpdate(<#T##currency: OfferSellCurrency##OfferSellCurrency#>)
                        }

                    } catch let error {
                        print(error)
                    }

                } else if let error = error {
                    print("HTTP Request Failed \(error)")
                }
            }
            task.resume()
        }
    } else {
        OfferSellManagerDelegate.didFailWithError(error)
    }
    
    func parseJSON(currencyData:Data) -> OfferSellCurrency? {
        let decoder = JSONDecoder()
        do {
          let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            let weatherModel = cu
            return weatherModel
        } catch {
            weatherDelegate?.didFailWithError(error)
            return nil
        }
    }
}
