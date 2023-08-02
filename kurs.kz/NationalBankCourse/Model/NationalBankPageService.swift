//
//  NationalBankPageService.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 02.08.2023.
//

import Foundation
import Alamofire

final class NationalBankPageService {
    
    // MARK: - Network
    
    func fetchNationalBankUrl(completion: @escaping (Result<NationalBankUrl, AFError>) -> Void) {
        var urlComponent = URLComponents()
        urlComponent.scheme = "http"
        urlComponent.host = "77.240.38.143"
        urlComponent.port = 4443
        urlComponent.path = "/profile/national_bank_rates"
        
        guard let url = urlComponent.url else {
            return
        }
        
        AF.request(url)
            .validate()
            .responseDecodable(of: NationalBankUrl.self) { data in
                completion(data.result)
            }
    }
}
