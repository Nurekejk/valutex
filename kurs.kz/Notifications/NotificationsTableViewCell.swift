//
//  NotificationsTableViewCell.swift
//  kurs.kz
//
//  Created by Акерке on 11.07.2023.
//

import UIKit
import SnapKit

final class NotificationsTableViewCell: UITableViewCell {

    // MARK: - UI

    private lazy var containerView: UIView = {
            let view = UIView()
            return view
        }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Тех. поддержка"
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()

    private lazy var subTitleTextField: UITextField = {
        let textField = UITextField()
        textField.text = "Добро пожаловать в службу поддержки"
        textField.font = .systemFont(ofSize: 16)
        return textField
    }()

    private lazy var dateTextField: UITextField = {
        let textField = UITextField()
        textField.text = "9:05"
        textField.font = .systemFont(ofSize: 14)
        textField.textColor = UIColor.lightGray
        textField.textAlignment = .right
        return textField
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func prepareForReuse() {
            super.prepareForReuse()

        }
    override func layoutSubviews() {
            super.layoutSubviews()

        containerView.layer.cornerRadius = 8
        containerView.layer.borderWidth = 0.5
        }

    // MARK: - Setup Views

       private func setupViews() {
           [titleLabel, subTitleTextField, dateTextField].forEach {
               containerView.addSubview($0)
           }

           contentView.addSubview(containerView)
       }

    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-8)
                }

        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-40)
            
        }
        subTitleTextField.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-40)
        }
       dateTextField.snp.makeConstraints { make in
            make.top.equalTo(subTitleTextField.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-40)
        }
    }
}
