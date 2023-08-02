//
//  Question.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 01.08.2023.
//

import Foundation

struct Question {
  var question: String
  var answer: String
  var collapsed: Bool
    
  init(question: String, answer: String, collapsed: Bool = true) {
    self.question = question
    self.answer = answer
    self.collapsed = collapsed
  }
}
