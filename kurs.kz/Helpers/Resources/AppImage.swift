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
    case zoom_in = "zoom-in"
    case zoom_out = "zoom-out"
    case my_exchanges_navigation = "my-exchanges-navigation"
    case my_location = "my-location"
    case bitcoin_exchange = "bitcoinExchange"
    case moneys = "moneys"
    case setting_3 = "setting-3"
    case notification = "notification"
    case language_circle = "language-circle"
    case global = "global"
    case profile_2user = "profile-2user"
    case messages = "messages"
    case info = "info"
    case message_question = "message-question"
    case bank = "bank"
    case logout = "logout"
    case arrow_right = "arrow-right"
    case new_message = "new-message"
    case avatar = "avatar"
    case arrow_up_collapse = "arrow-up-collapse"
    case arrow_down_collapse = "arrow-down-collapse"
    case call = "call"
    case clock = "clock"
    case link_2 = "link-2"
    case messenger = "messenger"
    case sms = "sms"
    case user_tag = "user-tag"
    case star_bold = "star-bold"
    case share_image = "share_image"
    case call_image = "call_image"
}
