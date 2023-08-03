//
//  DetailPageService.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 03.08.2023.
//

import Foundation
import Alamofire

final class DetailPageService {
    
    // MARK: - Network
    
    func fetchCurrencyInformation(officeID: Int,
                                  completion: @escaping (Result<[CurrencyElement], AFError>) -> Void) {
        var urlComponent = URLComponents()
        urlComponent.scheme = "http"
        urlComponent.host = "77.240.38.143"
        urlComponent.port = 4443
        urlComponent.path = "/exchange_offices/info_rates"
        urlComponent.query = "office_id=\(officeID)"
        
        guard let url = urlComponent.url else {
            fatalError()
        }
        
        AF.request(url, method: .post, parameters: [:], encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: [CurrencyElement].self) { response in
                switch response.result {
                case .success(let currencyInfo):
                    completion(.success(currencyInfo))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
    
    func fetchDetails(officeID: Int, completion: @escaping (Result<Details, AFError>) -> Void) {
        var urlComponent = URLComponents()
        urlComponent.scheme = "http"
        urlComponent.host = "77.240.38.143"
        urlComponent.port = 4443
        urlComponent.path = "/exchange_offices/info_main"
        urlComponent.query = "office_id=\(officeID)"
        
        guard let url = urlComponent.url else {
            fatalError()
        }
        
        AF.request(url, method: .post, parameters: [:], encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: Details.self) { response in
                switch response.result {
                case .success(let details):
                    completion(.success(details))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
    }
}
