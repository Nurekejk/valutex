//
//  CurrencyElement.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 03.08.2023.
//

import Foundation

struct CurrencyElement: Codable {
    let currencyCode, currencyFlag: String?
    let buyPrice, sellPrice: Double?
    let createdAt: String?

    enum CodingKeys: String, CodingKey {
        case currencyCode = "currency_code"
        case currencyFlag = "currency_flag"
        case buyPrice = "buy_price"
        case sellPrice = "sell_price"
        case createdAt = "created_at"
    }
}
