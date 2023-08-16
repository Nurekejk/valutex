//
//  Rate.swift
//  kurs.kz
//
//  Created by Diar Orynbek on 16.08.2023.
//

import Foundation

// MARK: - RateElement
struct RateElement: Codable {
    var fullName: String
    var score: Int
    var comment: String

    enum CodingKeys: String, CodingKey {
        case fullName = "full_name"
        case score, comment
    }
}

typealias Rate = [RateElement]
