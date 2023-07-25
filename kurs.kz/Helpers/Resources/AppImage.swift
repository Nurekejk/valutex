//
//  AppImage.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 19.07.2023.
//

import UIKit

protocol AppImageProtocol {
    var rawValue: String { get }
}

extension AppImageProtocol {

    var uiImage: UIImage? {
        guard let image = UIImage(named: rawValue) else {
            fatalError("Could not find image with name \(rawValue)")
        }
        return image
    }
    
    var systemImage: UIImage? {
        guard let image = UIImage(systemName: rawValue) else {
            fatalError("Could not find image with name \(rawValue)")
        }
        return image
    }
    
}

enum AppImage: String, AppImageProtocol {
    case home_gray = "home_gray"
    case home_selected = "home_selected"
    case money_gray = "money_gray"
    case money_selected = "money_selected"
    case other_gray = "other_gray"
    case other_selected = "other_selected"
    case golden_star = "golden_star"
    case gray_star = "gray_star"
    case eye_slash = "eye-slash"
    case on_boarding_image = "onboardingImage"
    case edit = "edit"
    case some_exchange = "some_exchange"
    case trash = "trash"
    case arrow_back = "arrow_back"
    case search_city = "searchCity"
    case select_city = "selectCity"
    case selected_city = "selectedCity"
    case select_language = "selectlanguage"
    case telegram_icon = "telegram_icon"
    case whatsapp_icon = "whatsapp_icon"
}
