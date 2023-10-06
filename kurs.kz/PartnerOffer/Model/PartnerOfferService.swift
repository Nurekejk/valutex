//
//  PartnerOfferService.swift
//  kurs.kz
//
//  Created by MacBook on 06.10.2023.
//

import Foundation
import Alamofire

struct PartnerOfferService {
    // MARK: - Network

    func fetchSentOffers(completion: @escaping (Result<[AcceptedSentOfferResponse], AFError>) -> Void) {
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "api.valutex.kz"
        urlComponent.path = "/sent_offers_response_list"

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
        .responseDecodable(of: [AcceptedSentOfferResponse].self) { response in
            switch response.result {
            case .success(let message):
                completion(.success(message))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchAcceptedOffers(completion: @escaping (Result<[AcceptedSentOfferResponse], AFError>) -> Void) {
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "api.valutex.kz"
        urlComponent.path = "/accepted_offers_response_list"

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
        .responseDecodable(of: [AcceptedSentOfferResponse].self) { response in
            switch response.result {
            case .success(let message):
                completion(.success(message))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchOfferRequests(completion: @escaping (Result<[AcceptedSentOfferResponse], AFError>) -> Void) {
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "api.valutex.kz"
        urlComponent.path = "/offers_list"

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
        .responseDecodable(of: [AcceptedSentOfferResponse].self) { response in
            switch response.result {
            case .success(let message):
                completion(.success(message))
            case .failure(let error):
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
