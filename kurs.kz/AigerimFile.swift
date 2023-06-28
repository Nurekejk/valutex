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
    
    // lists the local currency
    func getLocalCurrency() -> String {
        return localCurrency
    }
    
//    // lists all currency names
//    func listAllCurrencies() {
//        for currency in currencies {
//            print(currency)
//        }
//    }
    
    func convertToUSD() -> Double {
        //convert to usd
        return 0.0
    }
}
