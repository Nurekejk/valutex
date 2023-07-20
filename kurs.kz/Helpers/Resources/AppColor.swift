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
    case gray10
    case gray20
    case gray30
    case gray40
    case gray50
    case gray60
    case gray70
    case gray80
    case gray90
    case gray100
    case grayWhite
    case primaryBase
    case primarySecondary
    case statusError
    case statusSuccess
    case statusWarning
}
