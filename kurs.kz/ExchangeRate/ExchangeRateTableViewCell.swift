//
//  ExchangeRateTableViewCell.swift
//  kurs.kz
//
//  Created by Акерке on 12.07.2023.
//

import UIKit
import SnapKit

class ExchangeRateTableViewCell: UITableViewCell {
    // MARK: - Public

    public static var reuseIdentifier = String(describing: ExchangeRateTableViewCell.self)

    // MARK: - UI

    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()

    private let USDFlagImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "USDFlag")
        return image
    }()

    private lazy var currencyUSDLabel: UILabel = {
        let label = UILabel()
        label.text = "Доллар"
        label.font = .systemFont(ofSize: 16)
        return label
    }()

    private lazy var amountOfPurchaseUSDTextField: UITextField = {
        let textField = UITextField()
        textField.text = "500"
        textField.font = .systemFont(ofSize: 16)
        return textField
    }()
    //    private let rejectButton: UIButton = {
    //           let button = UIButton(type: .system)
    //           button.setTitle("Отклонить", for: .normal)
    //           button.tintColor = .red
    //           button.backgroundColor = UIColor(red: 0.96, green: 0.97, blue: 0.98, alpha: 1.0)
    //           button.layer.cornerRadius = 8
    //           button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
    //           return button
    //       }()
    // MARK: - Initializers

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
        amountOfPurchaseUSDTextField.layer.cornerRadius = 10
        amountOfPurchaseUSDTextField.layer.borderWidth = 1
        amountOfPurchaseUSDTextField.layer.borderColor = UIColor.gray.cgColor
    }
    // MARK: - Setup Views

    private func setupViews() {
        [currencyUSDLabel, USDFlagImage, amountOfPurchaseUSDTextField].forEach {
            containerView.addSubview($0)
        }
        contentView.backgroundColor = .systemGray6
        containerView.backgroundColor = .white
        contentView.addSubview(containerView)
    }
    // MARK: - Setup Constraints

    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.bottom.equalToSuperview().offset(-8)
        }
        USDFlagImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-301)
        }
        currencyUSDLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(18)
            make.leading.equalToSuperview().offset(58)
            make.trailing.equalToSuperview().offset(-196)
        }
        amountOfPurchaseUSDTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(163)
            make.trailing.equalToSuperview().offset(-116)
            make.height.equalTo(32)
        }
    }
}
