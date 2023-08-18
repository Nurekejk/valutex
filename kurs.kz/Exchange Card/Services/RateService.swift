//
//  RateService.swift
//  kurs.kz
//
//  Created by Nurgul on 16.08.2023.
//

import Foundation
import Alamofire

final class RateService {

    // MARK: - Network FetchRates
    func fetchRates(officeID: Int, completion: @escaping (Result<[Rate], AFError>) -> Void) {
        let officeIdQuery = URLQueryItem(name: "office_id", value: "\(officeID)")

        var urlComponent = URLComponents()
        urlComponent.scheme = "http"
        urlComponent.host = "134.122.66.97"
        urlComponent.port = 4443
        urlComponent.path = "/exchange_offices/info_feedback"
        urlComponent.queryItems = [officeIdQuery]

        guard let url = urlComponent.url else {
            completion(.failure(AFError.invalidURL(url: urlComponent)))
            return
        }

        AF.request(url, method: .post, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: [Rate].self) { response in
                completion(response.result)
            }
    }
}
