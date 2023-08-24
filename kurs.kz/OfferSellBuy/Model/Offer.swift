//
//  Offer.swift
//  kurs.kz
//
//  Created by Nurbol on 17.08.2023.
//

import Foundation

struct Offer: Encodable {
    let type: String
    let exchangeСurrency: String
    let exchangeAmount: Double
    let exchangeRate: Double
    
    init(type: String,
         exchangeСurrency: String,
         exchangeAmount: Double,
         exchangeRate: Double) {
        self.type = type
        self.exchangeСurrency = exchangeСurrency
        self.exchangeAmount = exchangeAmount
        self.exchangeRate = exchangeRate
    }
}

enum CodingKeys: String, CodingKey {
    case type
    case exchangeСurrency = "exchange_currency"
    case exchangeAmount = "exchange_amount"
    case exchangeRate = "exchange_rate"
    }

struct CreateOfferResponse: Codable {
    let Message: String
}
