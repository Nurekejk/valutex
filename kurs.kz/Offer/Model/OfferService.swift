//
//  OfferService.swift
//  kurs.kz
//
//  Created by Nurbol on 17.08.2023.
//

import Foundation
import Alamofire

struct OfferService {
    // MARK: - Network

    func deleteOffer() {
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "api.valutex.kz"
        urlComponent.path = "/delete_offer"
        guard let url = urlComponent.url else {
            return
        }
        
        var headers: HTTPHeaders = [
            "accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        getAuth(&headers)
        
        AF.request(url,
                   method: .delete,
                   headers: headers).responseDecodable(of: String.self) { response in
            switch response.result {
            case .success(let deleteResponse):
                print("Успешный запрос: \(deleteResponse)")
            case .failure(let error):
                print("Ошибка запроса: \(error)")
            }
        }
    }
    
    func updateOffer(exchangeAmount: Double, exchangeRate: Double,
                     completion: @escaping (Result<[String : String], AFError>) -> Void) {
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "api.valutex.kz"
        urlComponent.path = "/update_offer"
        
        guard let url = urlComponent.url else {
            return
        }
        
        var headers: HTTPHeaders = [
            "accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        getAuth(&headers)
        
        let parameters: [String: Any] = [ "exchange_amount": exchangeAmount,
                                          "exchange_rate": exchangeRate ]

        AF.request(url, method: .put,
                   parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        .validate()
        .responseDecodable(of: [String : String].self) { response in
            switch response.result {
            case .success(let message):
                completion(.success(message))
                print("message issss \(message)")
            case .failure(let error):
                completion(.failure(error))
                print("error issss \(error)")
            }
        }
    }
    
    func getAuth(_ headers: inout HTTPHeaders) {
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
//    func updateOffer(exchangeAmount: Double,
//                     exchangeRate: Double) {
//        let url = "http://77.240.38.143:4443/update_offer"
//        var headers: HTTPHeaders = [
//            "accept": "application/json",
//            "Content-Type": "application/json"
//        ]
//        let defaults = UserDefaults.standard
//        if let data = defaults.data(forKey: SignInViewController.defaultsTokensKey) {
//            do {
//                let tokens = try JSONDecoder().decode(SignInResponse.self, from: data)
//                if let accessToken = tokens.access_token {
//                    headers["Authorization"] = "Bearer \(String(describing: accessToken))"
//                }
//            } catch {
//                print("error while decoding")
//            }
//        }
//
//        let parameters: [String: Any] = [
//            "exchange_amount": exchangeAmount,
//            "exchange_rate": exchangeRate
//        ]
//
//        AF.request(url, method: .put,
//                   parameters: parameters,
//                   encoding: JSONEncoding.default,
//                   headers: headers).responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                print("Успешный запрос: \(value)")
//            case .failure(let error):
//                print("Ошибка запроса: \(error)")
//            }
//        }
//    }
}
