//
//  AboutCompany.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 02.08.2023.
//

import Foundation

struct AboutCompany: Codable {
    let paragraph0, paragraph1, paragraph2, paragraph3: String
    let paragraph4, paragraph5, paragraph6: String
    let contacts: Contacts
    
    enum CodingKeys: String, CodingKey {
        case paragraph0 = "paragraph 0"
        case paragraph1 = "paragraph 1"
        case paragraph2 = "paragraph 2"
        case paragraph3 = "paragraph 3"
        case paragraph4 = "paragraph 4"
        case paragraph5 = "paragraph 5"
        case paragraph6 = "paragraph 6"
        case contacts
    }
}

struct Contacts: Codable {
    let email, address, phone: String
}
