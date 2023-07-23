//
//  PhoneCell.swift
//  kurs.kz
//
//  Created by Diar Orynbek on 23.07.2023.
//

import UIKit
import SnapKit

final class PhoneCell: UITableViewCell {
    
    // MARK: - Public
    static let reuseID = String(describing: PhoneCell.self)
    
    // MARK: - UI
    private lazy var firstNumber: UILabel = {
        let label = UILabel()
        label.text = "Aidos"
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    
    private lazy var secondNumber: UILabel = {
        let label = UILabel()
        label.text = "Все отлично!"
        label.font = .boldSystemFont(ofSize: 14)
        label.textAlignment = .left
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
        contentView.addSubview(firstNumber)
        contentView.addSubview(secondNumber)
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        
        firstNumber.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(18)
        }
        
        secondNumber.snp.makeConstraints { make in
            make.top.equalTo(firstNumber.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(18)
        }
    }
    
    public func setupPhone(first: String, second: String) {
        firstNumber.text = first
        secondNumber.text = second
    }
}
