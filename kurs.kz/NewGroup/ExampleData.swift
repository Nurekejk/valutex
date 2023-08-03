//
//  Section.swift
//  kurs.kz
//
//  Created by Diar Orynbek on 03.08.2023.
//

import Foundation
import CollapsibleTableSectionViewController

//
// MARK: - Section Data Structure
//
public struct Item {
    var name: String
    
    public init(name: String) {
        self.name = name
    }
}

public struct Section {
    var name: String
    var iconImage: UIImage?
    var items: [Item]
    var collapsed: Bool
    
    public init(name: String,iconImage: UIImage?, items: [Item], collapsed: Bool = false) {
        self.name = name
        self.iconImage = iconImage
        self.items = items
        self.collapsed = collapsed
    }
}

public var sectionsData: [Section] = [
    Section(name: "Телефон", iconImage: UIImage(named: "phone"),
            items: [
                Item(name: "+7-701-476-99-99"),
                Item(name: "+7-701-476-99-99 ")
            ]),
    Section(name: "Время работы", iconImage: UIImage(named: "clock"),
            items: [
                Item(name: "Пн - 09:00 - 21:00"),
                Item(name: "Вт - 09:00 - 21:00"),
                Item(name: "Ср - 09:00 - 21:00"),
                Item(name: "Чт - 09:00 - 21:00"),
                Item(name: "Пт - 09:00 - 21:00"),
                Item(name: "Сб -  выходной"),
                Item(name: "Вс -  выходной")
            ]),
    Section(name: "Email", iconImage: UIImage(named: "whatsapp"),
            items: [
                Item(name: "mail@mail.ru")
            ])
]
