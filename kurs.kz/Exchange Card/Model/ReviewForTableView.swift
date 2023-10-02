//
//  ReviewForTableView.swift
//  kurs.kz
//
//  Created by MacBook on 26.09.2023.
//

import Foundation

struct ReviewForTableView: Decodable {
    let fullName: String?
    let score: Int?
    let comment: String?
    let createdAt: String?
    
    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case score, comment
        case createdAt = "created_at"
    }
}
