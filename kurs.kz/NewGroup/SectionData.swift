//
//  Section.swift
//  kurs.kz
//
//  Created by Diar Orynbek on 03.08.2023.
//

import Foundation
import CollapsibleTableSectionViewController

// MARK: - Section Data Structure
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
