//
//  MockExchanger.swift
//  kurs.kz
//
//  Created by MacBook on 23.07.2023.
//

import Foundation

struct MockExchanger: Codable {
    let id: String
    let mainTitle: String
    let iconImageName: String = "mig_icon"
    let rating: Float
    let totalRatings: Int
    let address: String
    let date: String
    let buyRate: Float
    let sellRate: Float
    let latitude: Float
    let longitude: Float
    
    enum CodingKeys: String, CodingKey {
        case id
        case mainTitle
        case iconImageName
        case rating = "score"
        case totalRatings = "score_count"
        case address
        case date = "created_at"
        case buyRate = "buy_price"
        case sellRate = "sell_price"
        case latitude
        case longitude
    }
}
