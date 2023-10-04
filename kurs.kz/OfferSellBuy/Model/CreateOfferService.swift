//
//  CreateOfferService.swift
//  kurs.kz
//
//  Created by Nurbol on 17.08.2023.
//

import Foundation
import Alamofire

final class CreateOfferService {
    // MARK: - Network

    func createOffer(offer: Offer,
                     completion: @escaping (Result<CreateOfferResponse, AFError>) -> Void) {

        var createOffer = URLComponents()
        createOffer.scheme = "https"
        createOffer.host = "api.valutex.kz"
        createOffer.path = "/create_offer"

        guard let url = createOffer.url else {
            print("error while creating URl")
            completion(.failure(.invalidURL(url: createOffer.url ?? "")))
            return
        }
        // swiftlint: disable all

        var headers: HTTPHeaders = [
            "accept": "application/json",
            "Content-Type": "application/json",
        ]
        let defaults = UserDefaults.standard
        if let data = defaults.data(forKey: SignInViewController.defaultsUserAndTokensKey) {
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
            "type": offer.type,
            "exchange_currency": offer.exchangeСurrency,
            "exchange_amount": offer.exchangeAmount,
            "exchange_rate": offer.exchangeRate
        ]

        AF.request(
            url,
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: headers).responseDecodable(of: CreateOfferResponse.self) { response in
                print("CODE", response.response?.statusCode)
                guard let data = response.data, response.error == nil else {
                    completion(.failure(.responseValidationFailed(reason: .dataFileNil)))
                    return
                }
                do {
                    let decodedData = try JSONDecoder().decode(CreateOfferResponse.self, from: data)
                    completion(.success(decodedData))
                } catch(_) {
                    completion(.failure(.explicitlyCancelled))
                }
            }
    }
}
