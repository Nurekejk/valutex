//
//  CalculatorService.swift
//  kurs.kz
//
//  Created by Акерке on 18.08.2023.
//

import Foundation
import Alamofire

struct CalculatorService {

    func fetchExchangers(currencyCode: String, cityId: Int, completion: @escaping ([Exchanger]) -> Void) {

        var exchangeListURLComponent = URLComponents()
        exchangeListURLComponent.scheme = "http"
        exchangeListURLComponent.host = "134.122.66.97"
        exchangeListURLComponent.port = 4443
        exchangeListURLComponent.path = "/actual_currency_rates"

        guard let url = exchangeListURLComponent.url else {
            return
        }

        let requestData: [String: Any] = ["currency_code": currencyCode, "city_id": cityId]

        AF.request(url,
                   method: .post,
                   parameters: requestData,
                   encoding: JSONEncoding.default,
                   headers:
                    ["Content-Type": "application/json"])
        .validate()
        .responseDecodable(of: [Exchanger].self) { response in
            switch response.result {
            case .success(let exchanger):
                completion(exchanger)
            case .failure(let error):
                print("Error fetching data: \(error)")
                completion([])
            }
        }
    }
}
