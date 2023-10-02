//
//  UserStatus.swift
//  kurs.kz
//
//  Created by MacBook on 02.10.2023.
//

import Foundation

struct UserStatus: Decodable {
    let status: Status?
    let data : [OfferData]?
    
    enum Status: String, Decodable {
        case create = "create"
        case offerCreated = "offer_created"
        case offerAccepted = "offer_accepted"
    }

}
struct OfferData: Decodable {
    let type, exchangeCurrency, createdAt: String?
    let exchangeRate, exchangeAmount, exchangeSum: Double?
    let userId, id: Int?
    
    enum CodingKeys: String, CodingKey {
        case type, id
        case exchangeCurrency = "exchange_currency"
        case exchangeRate = "exchange_rate"
        case userId = "user_id"
        case exchangeAmount = "exchange_amount"
        case exchangeSum = "exchange_sum"
        case createdAt = "created_at"
    }
}
