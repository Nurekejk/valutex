//
//  AppFont.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 20.07.2023.
//

import UIKit

protocol AppFontProtocol {
    var rawValue: String { get }
}

extension AppFontProtocol {
    
    func s12() -> UIFont {
        return apply(size: 12)
    }
    
    func s14() -> UIFont {
        return apply(size: 14)
    }
    
    func s16() -> UIFont {
        return apply(size: 16)
    }
    
    func s18() -> UIFont {
        return apply(size: 18)
    }
    
    func s20() -> UIFont {
        return apply(size: 20)
    }
    
    func s22() -> UIFont {
        return apply(size: 22)
    }
    
    func s24() -> UIFont {
        return apply(size: 24)
    }
    
    func s28() -> UIFont {
        return apply(size: 28)
    }
    
    func s32() -> UIFont {
        return apply(size: 32)
    }
    
    func s40() -> UIFont {
        return apply(size: 40)
    }
    
    func s48() -> UIFont {
        return apply(size: 48)
    }
}

extension AppFontProtocol {

    private func apply(size value: CGFloat) -> UIFont {
        var font: UIFont
        switch rawValue {
        case "regular":
            font = UIFont.systemFont(ofSize: value, weight: .regular)
        case "medium":
            font = UIFont.systemFont(ofSize: value, weight: .medium)
        case "semibold":
            font = UIFont.systemFont(ofSize: value, weight: .semibold)
        case "bold":
            font = UIFont.systemFont(ofSize: value, weight: .bold)
        default:
            font = UIFont.systemFont(ofSize: value, weight: .regular)
        }
        return font
    }
}

enum AppFont: String, AppFontProtocol {
    case reqular
    case medium
    case semibold
    case bold
}
