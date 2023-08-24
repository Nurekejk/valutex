//
//  OfferService.swift
//  kurs.kz
//
//  Created by Nurbol on 17.08.2023.
//

import Foundation
import Alamofire

final class OfferService {
    // MARK: - Network
    struct DeleteResponse: Decodable {
        let Message: String
    }

    func deleteOffer() {
        let url = "http://134.122.66.97:4443/delete_offer"
        var headers: HTTPHeaders = [
            "accept": "application/json"
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
        AF.request(url,
                   method: .delete,
                   headers: headers).responseDecodable(of: DeleteResponse.self) { response in
            switch response.result {
            case .success(let deleteResponse):
                print("Успешный запрос: \(deleteResponse)")
            case .failure(let error):
                print("Ошибка запроса: \(error)")
            }
        }
    }
//    func updateOffer(exchangeAmount: Double,
//                     exchangeRate: Double) {
//        let url = "http://77.240.38.143:4443/update_offer"
//        var headers: HTTPHeaders = [
//            "accept": "application/json",
//            "Content-Type": "application/json"
//        ]
//        let defaults = UserDefaults.standard
//        if let data = defaults.data(forKey: SignInViewController.defaultsTokensKey) {
//            do {
//                let tokens = try JSONDecoder().decode(SignInResponse.self, from: data)
//                if let accessToken = tokens.access_token {
//                    headers["Authorization"] = "Bearer \(String(describing: accessToken))"
//                }
//            } catch {
//                print("error while decoding")
//            }
//        }
//
//        let parameters: [String: Any] = [
//            "exchange_amount": exchangeAmount,
//            "exchange_rate": exchangeRate
//        ]
//
//        AF.request(url, method: .put,
//                   parameters: parameters,
//                   encoding: JSONEncoding.default,
//                   headers: headers).responseJSON { response in
//            switch response.result {
//            case .success(let value):
//                print("Успешный запрос: \(value)")
//            case .failure(let error):
//                print("Ошибка запроса: \(error)")
//            }
//        }
//    }
}
