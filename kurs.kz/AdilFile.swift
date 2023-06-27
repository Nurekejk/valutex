//
//  AdilFile.swift
//  kurs.kz
//
//  Created by Adil on 27.06.2023.
//

import Foundation

struct Movie {
    
    let title: String
    let hasAwards: [String]
    var isFavourite = false
    var numberOfAwards: Int {
        hasAwards.count
    }
    
    func getDescription() -> String {
        if numberOfAwards == 0 {
            let description = "\(title) has no awards. You probably shouldn't watch this movie :("
            return description
        } else {
            let awards = hasAwards.joined(separator: ", ")
            let description = "\(title) has \(numberOfAwards) awards: \(awards)"
            return description
        }
    }
    mutating func changeFavourite() {
        isFavourite = isFavourite ? false : true
    }
}
