//
//  UserStatus.swift
//  kurs.kz
//
//  Created by MacBook on 02.10.2023.
//

import Foundation

struct UserStatus: Decodable {
    let status: Status?
    let offerСreatedData: [OfferСreatedData]?
    let role: String?
    let offerAcceptedData: OfferAcceptedData?
    
    enum Status: String, Decodable {
        case create = "create"
        case offerCreated = "offer_created"
        case offerAccepted = "offer_accepted"
    }
}

struct OfferAcceptedData: Decodable {
    let repliedAt, statusType, exchangeCurrency, exchangeOffice, exchangeOfficeAddress: String?
    let exchangeAmount, exchangeRate, exchangeSum: Double?
    let exchangeId: Int
    
    enum CodingKeys: String, CodingKey {
        case repliedAt = "replied_at"
        case statusType = "status_type"
        case exchangeCurrency = "exchange_currency"
        case exchangeAmount = "exchange_amount"
        case exchangeRate = "exchange_rate"
        case exchangeSum = "exchange_sum"
        case exchangeId = "exchange_id"
        case exchangeOffice = "exchange_office"
        case exchangeOfficeAddress = "exchange_office_address"
    }
}

struct OfferСreatedData: Decodable {
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
