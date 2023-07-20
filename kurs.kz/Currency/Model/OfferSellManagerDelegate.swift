//
//  CurrencySelectorManager.swift
//  kurs.kz
//
//  Created by MacBook on 20.07.2023.
//

import Foundation

protocol CurrencySelectorManagerDelegate {
    func currencyDidUpdate(_ currency: Currency)
    func didFailWithError(_ error: Error)
}
