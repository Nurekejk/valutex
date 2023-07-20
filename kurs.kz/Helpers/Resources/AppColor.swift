//
//  AppColor.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 19.07.2023.
//

import UIKit

protocol AppColorProtocol {
    var rawValue: String { get }
}

extension AppColorProtocol {

    var uiColor: UIColor {
        guard let color = UIColor.init(named: rawValue) else {
            fatalError("Could not find color with name \(rawValue)")
        }
        return color
    }

    var cgColor: CGColor {
        return uiColor.cgColor
    }
}

enum AppColor: String, AppColorProtocol {
    case darkGray
    case backgroundGray
    case lightGray
    case lightGray2
    case mediumGray
    case primaryBlue
}