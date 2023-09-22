//
//  ExchangerListService.swift
//  kurs.kz
//
//  Created by MacBook on 23.07.2023.
//

import Foundation
import Alamofire

struct ExchangerListService {
    
    func fetchExchangers(currencyCode: String, cityId: Int, completion: @escaping ([Exchanger]) -> Void) {
        
        var exchangeListURLComponent = URLComponents()
        exchangeListURLComponent.scheme = "https"
        exchangeListURLComponent.host = "api.valutex.kz"
        exchangeListURLComponent.path = "/actual_currency_rates"
        
        let requestData: [String: Any] = ["currency_code": currencyCode, "city_id": cityId]
        
        AF.request(exchangeListURLComponent,
                   method: .post,
                   parameters: requestData,
                   encoding: JSONEncoding.default,
                   headers:
                    ["Content-Type": "application/json"])
        .validate()
        .responseDecodable(of: [Exchanger].self) { response in
            switch response.result {
            case .success(let exchangers):
                completion(exchangers)
            case .failure(let error):
                print("Error fetching data: \(error)")
                completion([])
            }
        }
    }
}
