//
//  Phone.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 22.07.2023.
//

import Foundation

struct User: Codable {
    let phone: String
    
    enum CodingKeys: String, CodingKey {
            case phone
        }
}
