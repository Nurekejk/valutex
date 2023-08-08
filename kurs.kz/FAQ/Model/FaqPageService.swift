//
//  FaqPageService.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 02.08.2023.
//

import Foundation
import Alamofire

final class FaqPageService {
    
    // MARK: - Network
    
    func fetchFaq(completion: @escaping (Result<QuestionAnswer, AFError>) -> Void) {
        var urlComponent = URLComponents()
        urlComponent.scheme = "http"
        urlComponent.host = "134.122.66.97"
        urlComponent.port = 4443
        urlComponent.path = "/profile/faq"
        
        guard let url = urlComponent.url else {
            return
        }
        
        AF.request(url)
            .validate()
            .responseDecodable(of: QuestionAnswer.self) { data in
                completion(data.result)
            }
    }
}
