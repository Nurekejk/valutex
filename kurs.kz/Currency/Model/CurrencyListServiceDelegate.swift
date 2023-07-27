//
//  CurrencyListServiceDelegate.swift
//  kurs.kz
//
//  Created by MacBook on 20.07.2023.
//

import Foundation

protocol CurrencyListServiceDelegate: AnyObject {
    func currencyDidUpdate(_ currency: [Currency])
    func didFailWithError(_ error: Error)
}
