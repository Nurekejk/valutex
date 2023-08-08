//
//  Section.swift
//  kurs.kz
//
//  Created by Diar Orynbek on 03.08.2023.
//

import Foundation
import CollapsibleTableSectionViewController

struct DetailSection {
    var name: String?
    var iconImage: UIImage?
    var items: [String?]?
    var collapsed: Bool?
    
    public init(name: String?,iconImage: UIImage?, items: [String?]?, collapsed: Bool = true) {
        self.name = name
        self.iconImage = iconImage
        self.items = items
        self.collapsed = collapsed
    }
}
