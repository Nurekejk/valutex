//
//  AcceptedSentOfferResponse.swift
//  kurs.kz
//
//  Created by MacBook on 06.10.2023.
//

import Foundation

struct AcceptedSentOfferResponse: Decodable {
    let userId, scoreCount, offerId: Int
    let userName, userSurname, userPhone, offerType, exchangeCurrency, exchangeCurrencySymbol, createdAt: String
    let score, exchangeAmount, exchangeRate, exchangeSum: Double
    
    enum CodingKeys: String, CodingKey {
        case score
        case userId = "user_id"
        case userName = "user_name"
        case userSurname = "user_surname"
        case userPhone = "user_phone"
        case scoreCount = "score_count"
        case offerId = "offer_id"
        case offerType = "offer_type"
        case exchangeCurrency = "exchange_currency"
        case exchangeCurrencySymbol = "exchange_currency_symbol"
        case exchangeAmount = "exchange_amount"
        case exchangeRate = "exchange_rate"
        case exchangeSum = "exchange_sum"
        case createdAt = "created_at"
    }
}
