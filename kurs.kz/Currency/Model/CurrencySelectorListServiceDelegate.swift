//
//  CurrencySelectorListServiceDelegate.swift
//  kurs.kz
//
//  Created by MacBook on 20.07.2023.
//

import Foundation

protocol CurrencySelectorListServiceDelegate: AnyObject {
    func currencyDidUpdate(_ currency: [Currency])
    func didFailWithError(_ error: Error)
}