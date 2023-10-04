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

    func deleteOffer(completion: @escaping (Result<[String : String], AFError>) -> Void) {
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

        AF.request(url, method: .delete, encoding: JSONEncoding.default, headers: headers)
        .validate()
        .responseDecodable(of: [String : String].self) { response in
            switch response.result {
            case .success(let message):
                completion(.success(message))
            case .failure(let error):
                completion(.failure(error))
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
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchOfferResponses(completion: @escaping (Result<[OfferResponseForTableView],
                                                    AFError>) -> Void) {
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "api.valutex.kz"
        urlComponent.path = "/offers_response_list"
        
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
        .responseDecodable(of: [OfferResponseForTableView].self) { response in
            switch response.result {
            case .success(let message):
                completion(.success(message))
            case .failure(let error):
                completion(.failure(error))
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
    
    func sendResponse(hasAccepted: Bool, offerResponseId: Int,
                      completion: @escaping (Result<[String : String], AFError>) -> Void) {
         var urlComponent = URLComponents()
         urlComponent.scheme = "https"
         urlComponent.host = "api.valutex.kz"
         urlComponent.path = "/offers_response_reply"
         
         guard let url = urlComponent.url else {
             return
         }
         
         var headers: HTTPHeaders = [
             "accept": "application/json",
             "Content-Type": "application/json"
         ]
         
         getAuth(&headers)
         
         let parameters: [String: Any] = [ "offer_response_id": offerResponseId,
                                           "is_declined": !hasAccepted,
                                           "is_accepted": hasAccepted]
        
         AF.request(url, method: .post,
                    parameters: parameters, encoding: JSONEncoding.default, headers: headers)
         .validate()
         .responseDecodable(of: [String : String].self) { response in
             switch response.result {
             case .success(let message):
                 completion(.success(message))
             case .failure(let error):
                 completion(.failure(error))
                 print("error while replying to offer \(error)")
             }
         }
     }
}
