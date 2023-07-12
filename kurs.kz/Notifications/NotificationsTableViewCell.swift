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

    private lazy var subTitleLabel: UITextField = {
        let label = UITextField()
        label.text = "Добро пожаловать в службу поддержки"
        label.font = .systemFont(ofSize: 16)
        return label
    }()

    private lazy var dateLabel: UITextField = {
        let label = UITextField()
        label.text = "9:05"
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor.lightGray
        label.textAlignment = .right
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        containerView.layer.cornerRadius = 8
        containerView.layer.borderWidth = 0.5
    }

    // MARK: - Setup Views

    private func setupViews() {
        [titleLabel, subTitleLabel, dateLabel].forEach {
            containerView.addSubview($0)
        }
        let backgroundGrayColor = UIColor(
            red: 246.0 / 255.0,
            green: 247.0 / 255.0,
            blue: 249.0 / 255.0,
            alpha: 1)

        contentView.backgroundColor = backgroundGrayColor // rgba(246, 247, 249, 1)
        containerView.backgroundColor = .white
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
            make.leading.equalToSuperview().offset(26)
        }

        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(26)

        }
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(8)
            make.trailing.equalToSuperview().offset(-40)
        }
    }
}
