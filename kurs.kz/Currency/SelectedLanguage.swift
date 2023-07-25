//
//  SelectedLanguage.swift
//  kurs.kz
//
//  Created by MacBook on 21.07.2023.
//

import Foundation

// MARK: - State
public enum Language {
    case english
    case russian
    case kazakh
}

public let selectedLanguage = Language.russian

public func getCurrencyName(_ currency: Currency, language: Language) -> String {
    switch language {
    case .english:
        return currency.englishName
    case .russian:
        return currency.russianName
    case .kazakh:
        return currency.kazakhName
    }
}
