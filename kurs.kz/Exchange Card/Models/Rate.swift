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
    var comment: String

    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case score, comment
    }
    
    init(fullName: String, score: Int, comment: String) {
        self.fullName = fullName
        self.score = score
        self.comment = comment
    }
}
