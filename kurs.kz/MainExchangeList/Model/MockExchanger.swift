//
//  MockExchanger.swift
//  kurs.kz
//
//  Created by MacBook on 23.07.2023.
//

import Foundation

struct MockExchanger: Codable {
    let id: Int
    let mainTitle: String
    let iconImageName: String = "mig_exchange"
    let rating: Float
    let totalRatings: Int
    let address: String
    let date: String
    let buyRate: Float
    let sellRate: Float
    let latitude: Float
    let longitude: Float
    let open: Bool
    let contacts: [String]
    
    enum CodingKeys: String, CodingKey {
        case id
        case mainTitle = "name"
        case iconImageName
        case rating = "score"
        case totalRatings = "score_count"
        case address
        case date = "created_at"
        case buyRate = "buy_price"
        case sellRate = "sell_price"
        case latitude
        case longitude
        case open
        case contacts
    }
}
