//
//  AigerimFile.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 28.06.2023.
//

import Foundation

struct Currency {
    let currencies: [String]
    let localCurrency: String
    
    func getLocalCurrency() -> String {
        return localCurrency
    }
    
    func listAllCurrencies() {
        for currency in currencies {
            print(currency)
        }
    }
}
