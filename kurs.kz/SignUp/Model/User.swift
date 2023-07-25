//
//  Phone.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 22.07.2023.
//

import Foundation

struct User: Codable {
    let name: String
    let surname: String
    let middleName: String
    let password: String
    let phone: String
    let deviceID: String
    let language: String
    let currencyCode: String
    let cityID: Int
    let smsCode: Int
    
    enum CodingKeys: String, CodingKey {
        case name
        case surname
        case middleName = "middle_name"
        case password
        case phone
        case deviceID = "device_id"
        case language
        case currencyCode = "currency_code"
        case cityID = "city_id"
        case smsCode = "sms_code"
        }
}
