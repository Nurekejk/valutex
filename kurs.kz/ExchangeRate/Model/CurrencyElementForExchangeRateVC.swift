//
//  CurrencyElementForExchangeRateVC.swift
//  kurs.kz
//
//  Created by MacBook on 13.10.2023.
//

import Foundation

struct CurrencyElementForExchangeRateVC: Decodable {
    let currencyRateId: Int?
    let currencyCode, currencyFlag, currencyKzName, currencyRuName, currencyEngName: String?
    let buyPrice, sellPrice: Double?
    
    enum CodingKeys: String, CodingKey {
        case currencyRateId = "currency_rate_id"
        case currencyCode = "currency_code"
        case currencyFlag = "currency_flag"
        case currencyKzName = "currency_kz_name"
        case currencyRuName = "currency_ru_name"
        case currencyEngName = "currency_eng_name"
        case buyPrice = "buy_price"
        case sellPrice = "sell_price"
    }
}
