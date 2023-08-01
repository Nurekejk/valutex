//
//  FaqAnswerTableViewCell.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 01.08.2023.
//

import UIKit

final class FaqAnswerTableViewCell: UITableViewCell {
    // MARK: - State
    static let reuseID = String(describing: FaqAnswerTableViewCell.self)
    
    // MARK: - UI
    private lazy var answerLabel: UILabel = {
        let label = UILabel()
        label.text = """
                    Metalink - это ведущая компания, специализирующаяся на агрегации курсов валют и предоставлении информационных услуг по валютам.
                    """
        label.textColor = AppColor.gray100.uiColor
        label.font = AppFont.regular.s14()
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        [answerLabel].forEach {
            contentView.addSubview($0)
        }
    }
}
