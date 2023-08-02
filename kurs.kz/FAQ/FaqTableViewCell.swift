//
//  FaqAnswerTableViewCell.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 01.08.2023.
//

import UIKit

final class FaqTableViewCell: UITableViewCell {
    // MARK: - State
    static let reuseID = String(describing: FaqTableViewCell.self)
    
    var faqSection: Question? {
        didSet {
            answerLabel.text = faqSection?.answer
        }
    }
    
    // MARK: - UI
    private lazy var answerLabel: UILabel = {
        let label = UILabel()
        label.text = """
                    Metalink - это ведущая компания, специализирующаяся на
                    агрегации курсов валют и предоставлении информационных услуг по
                    валютам.
                    """
        label.textColor = AppColor.gray70.uiColor
        label.font = AppFont.regular.s14()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
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
        contentView.addSubview(answerLabel)
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        answerLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(8)
            make.trailing.bottom.equalToSuperview().offset(-8)
        }
    }
}
