//
//  BekzhanFile.swift
//  kurs.kz
//
//  Created by Bekzhan Askerbekov on 28/6/23.
//

import Foundation

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
}
