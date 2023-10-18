//
//  ExchangeRateService.swift
//  kurs.kz
//
//  Created by MacBook on 13.10.2023.
//

import Foundation
import Alamofire

struct ExchangeRateService {
    
    // MARK: - Network
    func fetchCurrencyRates(completion: @escaping (Result<[CurrencyElementForExchangeRateVC],
                                                    AFError>) -> Void) {
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "api.valutex.kz"
        urlComponent.path = "/profile/currency_rates"

        guard let url = urlComponent.url else {
            return
        }
        
        var headers: HTTPHeaders = [
            "accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        getAuth(&headers)

        AF.request(url, method: .get, encoding: JSONEncoding.default, headers: headers)
        .validate()
        .responseDecodable(of: [CurrencyElementForExchangeRateVC].self) { response in
            switch response.result {
            case .success(let message):
                completion(.success(message))
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }
    
    func createCurrencyRate(
        newCurrencyRate: CurrencyElementForExchangeRateVC,
        completion: @escaping (Result<[String : String], AFError>) -> Void) {
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "api.valutex.kz"
        urlComponent.path = "/profile/create_currency_rate"

        guard let url = urlComponent.url else {
            return
        }
        
        var headers: HTTPHeaders = [
            "accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        getAuth(&headers)

        let parameters: Parameters = [
            "currency_code": newCurrencyRate.currencyCode ?? "",
            "buy_price": newCurrencyRate.buyPrice ?? 0.0,
            "sell_price": newCurrencyRate.sellPrice ?? 0.0
        ]
        
        AF.request(url,
                   method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: headers)
        .validate()
        .responseDecodable(of: [String : String].self) { response in
            switch response.result {
            case .success(let message):
                completion(.success(message))
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }
    
    public func updateCurrencies(currencyId: Int,
                                 buyPrice: Double,
                                 sellPrice: Double,
                                 completion: @escaping (Result<[String : String], AFError>) -> Void) {
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "api.valutex.kz"
        urlComponent.path = "/profile/update_currency_rate"

        guard let url = urlComponent.url else {
            return
        }
        
        var headers: HTTPHeaders = [
            "accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        let parameters: Parameters = [
            "currency_id": currencyId,
            "buy_price": buyPrice,
            "sell_price": sellPrice
        ]
        
        getAuth(&headers)

        AF.request(
            url, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        .validate()
        .responseDecodable(of: [String : String].self) { response in
            switch response.result {
            case .success(let message):
                completion(.success(message))
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }
    
    public func deleteCurrencies(currencyId: Int,
                                 completion: @escaping (Result<[String : String], AFError>) -> Void) {
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "api.valutex.kz"
        urlComponent.path = "/profile/delete_currency_rate"
        urlComponent.query = "currency_id=\(currencyId)"

        guard let url = urlComponent.url else {
            return
        }
        
        var headers: HTTPHeaders = [
            "accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        getAuth(&headers)

        AF.request(url, method: .delete, encoding: JSONEncoding.default, headers: headers)
        .validate()
        .responseDecodable(of: [String : String].self) { response in
            switch response.result {
            case .success(let message):
                completion(.success(message))
            case .failure(let error):
                print(error)
                completion(.failure(error))
            }
        }
    }
    
    private func getAuth(_ headers: inout HTTPHeaders) {
        let defaults = UserDefaults.standard
        if let data = defaults.data(forKey: SignInViewController.defaultsUserAndTokensKey) {
            do {
                let tokens = try JSONDecoder().decode(SignInResponse.self, from: data)
                if let accessToken = tokens.access_token {
                    
                    headers["Authorization"] = "Bearer \(accessToken)"
                }
            } catch {
                print("error while decoding")
            }
        }
    }
}
