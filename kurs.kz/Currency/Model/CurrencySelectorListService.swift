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
        currencyListURLComponent.scheme = "https"
        currencyListURLComponent.host = "api.valutex.kz"
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
