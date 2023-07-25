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
    var password: String
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
    
    init(name: String, surname: String, middleName: String, phone: String, deviceID: String, language: String, currencyCode: String, cityID: Int, smsCode: String) {
        self.name = name
        self.surname = surname
        self.middleName = middleName
        self.password = ""
        self.phone = phone
        self.deviceID = deviceID
        self.language = language
        self.currencyCode = currencyCode
        self.cityID = cityID
        self.smsCode = Int(smsCode) ?? 0
    }
    
    mutating func setPassword(password: String) {
        self.password = password
    }
}
