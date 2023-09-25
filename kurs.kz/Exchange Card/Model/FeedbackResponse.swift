//
//  CompletedFeedback.swift
//  kurs.kz
//
//  Created by MacBook on 25.09.2023.
//

import Foundation

struct FeedbackResponse: Decodable {
    
    let status: Bool?
    let feedback: CompletedFeedback? 
}

struct CompletedFeedback: Decodable {
    
    let officeId: Int?
    let score: Int?
    let editedFlag: Bool?
    let createdAt: String?
    let id: Int?
    let userId: Int?
    let comment: String?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case officeId = "office_id"
        case score
        case editedFlag = "edited_flag"
        case createdAt = "created_at"
        case id
        case userId = "user_id"
        case comment
        case updatedAt = "updated_at"
    }
}
