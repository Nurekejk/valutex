//
//  OfferSellManagerDelegate.swift
//  kurs.kz
//
//  Created by MacBook on 20.07.2023.
//

import Foundation

protocol OfferSellManagerDelegate {
    func currencyDidUpdate(_ currency: OfferSellCurrency)
    func didFailWithError(_ error: Error)
}
