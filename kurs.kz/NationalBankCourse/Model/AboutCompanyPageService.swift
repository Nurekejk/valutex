//
//  AboutCompanyPageService.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 02.08.2023.
//

import Foundation
import Alamofire

final class AboutCompanyPageService {
    
    // MARK: - Network
    func fetchAboutCompanyText(completion: @escaping (Result<AboutCompany, AFError>) -> Void) {
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "api.valutex.kz"
        urlComponent.path = "/profile/about_the_company"
        
        guard let url = urlComponent.url else {
            return
        }
        
        AF.request(url)
            .validate()
            .responseDecodable(of: AboutCompany.self) { data in
                completion(data.result)
            }
    }
}
