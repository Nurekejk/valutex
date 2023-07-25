//
//  WhatsappCell.swift
//  kurs.kz
//
//  Created by Diar Orynbek on 25.07.2023.
//

import UIKit
import SnapKit

final class WhatsappCell: UITableViewCell {
    
    // MARK: - Public
    static let reuseID = String(describing: WhatsappCell.self)
    
    // MARK: - UI
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.text = "+7-701-476-99-99"
        label.font = AppFont.medium.s14()
        return label
    }()
    
    // MARK: - Life Cycle
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
        [numberLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        numberLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(18)
        }
    }
}
