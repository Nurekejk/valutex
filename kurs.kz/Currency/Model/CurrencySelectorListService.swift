//
//  CurrencySelectorListService.swift
//  kurs.kz
//
//  Created by MacBook on 20.07.2023.
//

import Foundation
import Alamofire

struct CurrencySelectorListService {
    
    weak var delegate: CurrencySelectorListServiceDelegate?
    
    func fetchCurrencies() {
        
        var currencyListURLComponent = URLComponents()
        currencyListURLComponent.scheme = "http"
        currencyListURLComponent.host = "134.122.66.97"
        currencyListURLComponent.port = 4443
        currencyListURLComponent.path = "/currencies_list"
        
        guard let url = currencyListURLComponent.url else {
            return
        }
        AF.request(url)
            .validate()
            .responseDecodable(of: [Currency].self) { data in
                switch data.result {
                case .success(let fetchedCurrencies):
                    self.delegate?.currencyDidUpdate(fetchedCurrencies)
                case .failure(let error):
                    self.delegate?.didFailWithError(error)
                }
            }
    }
}
