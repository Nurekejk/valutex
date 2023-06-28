//
//  BekzhanFile.swift
//  kurs.kz
//
//  Created by Bekzhan Askerbekov on 28/6/23.
//

import Foundation
import UIKit

struct Book {
    let title: String
    let author: String
    var currentPage: Int
    var isRead: Bool
    
    mutating func turnPage() {
        currentPage += 1
        if currentPage >= pageCount {
            isRead = true
        }
    }
    
    func summary() -> String {
        return "\(title) by \(author). \(isRead ? "Finished reading." : "Currently on page \(currentPage).")"
    }
    
    let pageCount: Int
}
