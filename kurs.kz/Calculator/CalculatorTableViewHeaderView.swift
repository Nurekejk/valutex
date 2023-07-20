//
//  CalculatorTableViewHeaderView.swift
//  kurs.kz
//
//  Created by Акерке on 19.07.2023.
//

import UIKit
import SnapKit

final class CalculatorTableViewHeaderView: UITableViewHeaderFooterView {

    // MARK: - UI

    private lazy var flagImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "KZTflag")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private lazy var currencyLabel: UILabel = {
        let label = UILabel()
        label.text = "KZT"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    private lazy var dropDownButton: UIButton = {
        let button = UIButton(type: .system)
        let iconImage = UIImage(named: "drop-down")
        button.setImage(iconImage, for: .normal)
        button.addTarget(self, action: #selector(dropDownButtonDidPressed),
                         for: .touchUpInside)
        return button
    }()
    private lazy var separatorLineImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "separator-line")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private lazy var arrowLeftRightButton: UIButton = {
        let button = UIButton(type: .system)
        let iconImage = UIImage(named: "arrow-left-right")
        button.setImage(iconImage, for: .normal)
        button.addTarget(self, action: #selector(arrowLeftRightButtonDidPressed),
                         for: .touchUpInside)
        return button
    }()

    // MARK: - LifeCycle

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup Views

    private func setupViews() {
        [flagImage, currencyLabel, dropDownButton, separatorLineImage, arrowLeftRightButton].forEach {
            contentView.addSubview($0)
        }
        contentView.backgroundColor = .white
    }
    // MARK: - Setup Constraints

    func setupConstraints() {
        flagImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        currencyLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14)
            make.leading.equalTo(flagImage.snp.trailing).offset(16)
        }
        dropDownButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(21.54)
            make.leading.equalTo(dropDownButton.snp.trailing).offset(16)
        }
        separatorLineImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalTo(dropDownButton.snp.trailing).offset(33.5)
        }
        arrowLeftRightButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalTo(separatorLineImage.snp.trailing).offset(12)
        }
        separatorLineImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalTo(arrowLeftRightButton.snp.trailing).offset(12)
        }
        dropDownButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(21.54)
            make.leading.equalToSuperview().offset(18.5)
        }
        currencyLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14)
            make.trailing.equalTo(dropDownButton.snp.leading).offset(-16)
        }
        flagImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.trailing.equalTo(currencyLabel.snp.leading).offset(-16)
        }

    }

    // MARK: - Actions

    @objc private func dropDownButtonDidPressed() {

    }
    @objc private func arrowLeftRightButtonDidPressed() {

    }
}
