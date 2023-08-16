//
//  RateService.swift
//  kurs.kz
//
//  Created by Diar Orynbek on 15.08.2023.
//

import Foundation
import Alamofire

final class RateService {
    
    func fetchFeedback(with office_id: Int, completion: @escaping ([Rate]) -> Void) {
        
        var urlComponent = URLComponents()
        urlComponent.scheme = "http"
        urlComponent.host = "134.122.66.97"
        urlComponent.port = 4443
        urlComponent.path = "/exchange_office/info_feedback"
        
        guard let url = urlComponent.url else {
            return
        }
        
        let paramerts: [String: Any] = ["office_id": office_id]
        
        AF.request(url,
                   method: .post,
                   parameters: paramerts,
                   encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: [Rate].self) { data in
                print(data.result)
            }
    }
}
