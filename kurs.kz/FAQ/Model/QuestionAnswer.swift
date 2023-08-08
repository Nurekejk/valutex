//
//  FAQ.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 02.08.2023.
//

import Foundation

struct QuestionAnswer: Codable {
    let faq: [FAQs]
}

struct FAQs: Codable {
    let question, answer: String
}
