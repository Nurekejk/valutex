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
        urlComponent.scheme = "https"
        urlComponent.host = "api.valutex.kz"
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
