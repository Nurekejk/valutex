//
//  UserStatus.swift
//  kurs.kz
//
//  Created by MacBook on 02.10.2023.
//

import Foundation

struct UserStatus: Decodable {
    let status: Status
    let role: String?
    let data: Any
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        status = try container.decode(Status.self, forKey: .status)
        role = try container.decodeIfPresent(String.self, forKey: .role)

        switch status {
        case .offerCreated:
            data = try container.decode([OfferCreatedData].self, forKey: .data)
        case .offerAccepted:
            data = try container.decode(OfferAcceptedData.self, forKey: .data)
        case .create:
            data = "" // You can assign a default value or handle it differently
        }
    }
    
    enum Status: String, Decodable {
        case create = "create"
        case offerCreated = "offer_created"
        case offerAccepted = "offer_accepted"
    }
    
    enum CodingKeys: String, CodingKey {
        case status, role, data
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

struct OfferCreatedData: Decodable {
    let type, exchangeCurrency, createdAt, currencyFlag, currencySymbol: String?
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
        case currencyFlag = "currency_flag"
        case currencySymbol = "currency_symbol"
    }
}
