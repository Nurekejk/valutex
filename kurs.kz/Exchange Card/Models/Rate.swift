//
//  Rate.swift
//  kurs.kz
//
//  Created by Diar Orynbek on 16.08.2023.
//

import Foundation

// MARK: - RateElement
struct Rate: Codable {
    var fullName: String
    var score: Int
    var comment, createdAt: String

    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case score, comment
        case createdAt = "created_at"
    }
    init(fullName: String, score: Int, comment: String, createdAt: String) {
        self.fullName = fullName
        self.score = score
        self.comment = comment
        self.createdAt = createdAt
    }
}

struct RateResponse: Codable {
    let Message: String
}
