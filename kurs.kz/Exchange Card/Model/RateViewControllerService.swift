//
//  RateViewControllerService.swift
//  kurs.kz
//
//  Created by MacBook on 19.09.2023.
//

import UIKit
import Alamofire

final class RateViewControllerService {
    // MARK: - Network
    
    func postReview(review: Feedback, completion: @escaping (Result<String, AFError>) -> Void) {
        var urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "api.valutex.kz"
        urlComponent.path = "/exchange_offices/give_feedback"
        
        guard let url = urlComponent.url else {
            return
        }
        print(url)
        
        var headers: HTTPHeaders = [
            "accept": "application/json",
            "Content-Type": "application/json"
        ]
        
        getAuth(&headers)
        let parameters: [String: Any] = [ "office_id": review.officeId,
                                          "score": review.score,
                                          "comment": review.comment]
        
        AF.request(url, method: .post,
                   parameters: parameters, encoding: JSONEncoding.default, headers: headers)
        .validate()
        .responseDecodable(of: String.self) { response in
            switch response.result {
            case .success(let message):
                completion(.success(message))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getAuth(_ headers: inout HTTPHeaders) {
        let defaults = UserDefaults.standard
        if let data = defaults.data(forKey: SignInViewController.defaultsUserAndTokensKey) {
            do {
                let tokens = try JSONDecoder().decode(SignInResponse.self, from: data)
                if let accessToken = tokens.access_token {
                    headers["Authorization"] = "Bearer \(accessToken)"
                }
            } catch {
                print("error while decoding")
            }
        }
    }
}