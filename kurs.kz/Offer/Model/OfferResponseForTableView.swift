//
//  OfferResponseForTableView.swift
//  kurs.kz
//
//  Created by MacBook on 02.10.2023.
//

import Foundation

struct OfferResponseForTableView: Decodable {
    let officeId, scoreCount, offerResponseId, offerId: Int?
    let officeName, officeAddress : String?
    let score, exchangeRate, officeLatitude, officeLongitude: Double?
    let isDeclined, isAccepted: Bool?
    
    enum CodingKeys: String, CodingKey {
        case score
        case officeId = "office_id"
        case scoreCount = "score_count"
        case offerResponseId = "offer_response_id"
        case offerId = "offer_id"
        case officeName = "office_name"
        case officeAddress = "office_address"
        case officeLatitude = "office_latitude"
        case officeLongitude = "office_longitude"
        case exchangeRate = "exchange_rate"
        case isDeclined = "is_declined"
        case isAccepted = "is_accepted"
    }
}
