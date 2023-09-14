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
    
    func fetchWrite(officeID: Int,
                    score: Int,
                    comment: String,
                    completion: @escaping (Result<RateResponse, AFError>) -> Void) {
        var fetchWrite = URLComponents()
        fetchWrite.scheme = "http"
        fetchWrite.host = "134.122.66.97"
        fetchWrite.port = 4443
        fetchWrite.path = "/exchange_offices/give_feedback"

        guard let url = fetchWrite.url else {
            print("error while creating URl")
            completion(.failure(.invalidURL(url: fetchWrite.url ?? "")))
            return
        }
        // swiftlint: disable all

        var headers: HTTPHeaders = [
            "accept": "application/json",
            "Content-Type": "application/json",
        ]
        let defaults = UserDefaults.standard
        if let data = defaults.data(forKey: SignInViewController.defaultsTokensKey) {
            do {
                let tokens = try JSONDecoder().decode(SignInResponse.self, from: data)
                if let accessToken = tokens.access_token {
                    headers["Authorization"] = "Bearer \(String(describing: accessToken))"
                }
            } catch {
                print("error while decoding")
            }
        }
        // swiftlint: enable all
        let parameters: Parameters = [
            "office_id": officeID,
            "score": score,
            "comment": comment
        ]

        AF.request(url, method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: headers).responseDecodable(of: RateResponse.self) { response in
            print("CODE", response.response?.statusCode as Any)
            guard let data = response.data, response.error == nil else {
                completion(.failure(.responseValidationFailed(reason: .dataFileNil)))
                return
            }
            do {
                let decodedData = try JSONDecoder().decode(RateResponse.self, from: data)
                completion(.success(decodedData))
            } catch(_) {
                completion(.failure(.explicitlyCancelled))
            }
        }
    }
}
