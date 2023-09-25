//
//  CompletedFeedback.swift
//  kurs.kz
//
//  Created by MacBook on 25.09.2023.
//

import Foundation
struct CompletedFeedback: Decodable  {
    let status: Bool?
    let feedback: Feedback? 
}


struct Feedback: Codable {
    let officeId: Int
    let score: Int
    let comment: String
    
    enum CodingKeys: String, CodingKey {
        case officeId = "office_id"
        case score
        case editedFlag = "edited_flag"
        case createdAt = "created_at"
        case id
        case userId = "user_id"
        case comment
        case updatedAt = "updated_at"
        case webSite = "web_site"
        case email
        case scoreCount = "score_count"
        case open = "open"
    }
}
