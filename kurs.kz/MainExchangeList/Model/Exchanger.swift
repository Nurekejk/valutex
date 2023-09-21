//
//  Exchanger.swift
//  kurs.kz
//
//  Created by MacBook on 16.07.2023.
//

import Foundation
import GoogleMaps

struct Exchanger: Codable {
    let id: Int
    let mainTitle: String
    let iconImageName: String = "mig_exchange"
    let rating: Float
    let totalRatings: Int
    let address: String
    let date: String
    var formattedDate: String? {
        getDate(from: date)
    }
    let buyRate: Float
    let sellRate: Float
    let latitude: Float
    let longitude: Float
    let open: Bool
    let contacts: [String]
    var distance: CLLocationDistance?
    
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
    
    func getDate(from dateString: String) -> String {
        if let dotIndex = dateString.firstIndex(of: ".") {
            let trimmedDate = String(dateString[..<dotIndex])
            let formatter = ISO8601DateFormatter()
            if let date = formatter.date(from: trimmedDate + "Z") {
                let outputFormatter = DateFormatter()
                outputFormatter.dateFormat = "dd MMMM yyyy, HH:mm:ss"
                outputFormatter.timeZone = TimeZone.current
                
                return outputFormatter.string(from: date)
            }
        }
        return "error processing date"
    }
}
