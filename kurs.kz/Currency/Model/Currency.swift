//
//  Currency.swift
//  kurs.kz
//
//  Created by MacBook on 20.07.2023.
//

import Foundation

public struct Currency: Codable {
    let flag: String
    let russianName: String
    let symbol: String
    let code: String
    let kazakhName: String
    let englishName: String
    
    enum CodingKeys: String, CodingKey {
        case flag
        case symbol
        case code
        case russianName = "ru_name"
        case kazakhName = "kz_name"
        case englishName = "eng_name"
    }
}
