//
//  SectionNetworkData.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 03.08.2023.
//

import Foundation

struct Details: Codable {
    let name, address: String?
    let latitude, longitude: Double?
    let schedule: [Schedule]?
    let contacts: [String?]?
    let whatsapp: [String?]?
    let webSite, email: String?
    let score, scoreCount: Int?
    let open: Bool?
    
    enum CodingKeys: String, CodingKey {
        case name, address, latitude, longitude, schedule, contacts, whatsapp
        case webSite = "web_site"
        case email, score
        case scoreCount = "score_count"
        case open = "open"
    }
}

struct Schedule: Codable {
    let from, to: String?
}
