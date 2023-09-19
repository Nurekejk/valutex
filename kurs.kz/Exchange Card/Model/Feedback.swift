//
//  Feedback.swift
//  kurs.kz
//
//  Created by MacBook on 19.09.2023.
//

import Foundation

struct Feedback: Encodable {
    let officeId: Int
    let score: Int
    let comment: String
}
