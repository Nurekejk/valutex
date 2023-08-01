//
//  FaqTableViewCell.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 01.08.2023.
//

import UIKit

final class FaqTableViewCell: UITableViewCell {
    // MARK: - State
    static let reuseID = String(describing: ProfileTableViewCell.self)
    
    // MARK: - UI
    private lazy var questionTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "Что такое Metalink?"
        label.textColor = AppColor.gray100.uiColor
        label.font = AppFont.regular.s14()
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    
}
