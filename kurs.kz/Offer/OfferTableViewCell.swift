//
//  OfferTableViewCell.swift
//  kurs.kz
//
//  Created by Nurbol on 09.07.2023.
//

import UIKit

final class OfferTableViewCell: UITableViewCell {

    // MARK: - Outlets
    private let cellView: UIView = {
        let cellView = UIView()
        cellView.backgroundColor = .white
        cellView.layer.cornerRadius = 8
        return cellView
    }()

    private let infoview: UIView = {
        let infoview = UIView()
        infoview.backgroundColor = .white
        return infoview
    }()

    private let infoStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .leading
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 4
        return stack
    }()

    private let locationStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .leading
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 8
        return stack
    }()

    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Som Exchange"
        label.font = .systemFont(ofSize: 14)
        return label
    }()

    private let starImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = UIImage(named: "star")
        return image
    }()

    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "5 (15)"
        label.font = .systemFont(ofSize: 12)
        return label
    }()

    private let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "г.Алматы, ул. Ауэзова 14"
        label.font = .systemFont(ofSize: 14)
        return label
    }()

    private let distanceLabel: UILabel = {
        let label = UILabel()
        label.text = "(1 км)"
        label.font = .systemFont(ofSize: 14)
        return label
    }()

    private let exchangeRateLabel: UILabel = {
        let label = UILabel()
        label.text = "505 ₸"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()

    private let rejectButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Отклонить", for: .normal)
        button.tintColor = .red
        button.backgroundColor = UIColor(red: 0.96, green: 0.97, blue: 0.98, alpha: 1.0)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()

    private let acceptButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Принять", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(red: 45/255, green: 156/255, blue: 219/255, alpha: 1)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        return button
    }()
    
    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup
    private func setupHierarchy() {
        infoStack.addArrangedSubview(nameLabel)
        infoStack.addArrangedSubview(starImage)
        infoStack.addArrangedSubview(ratingLabel)

        locationStack.addArrangedSubview(locationLabel)
        locationStack.addArrangedSubview(distanceLabel)

        infoview.addSubview(infoStack)
        infoview.addSubview(locationStack)
        cellView.addSubview(infoview)
        cellView.addSubview(exchangeRateLabel)
        cellView.addSubview(rejectButton)
        cellView.addSubview(acceptButton)

        contentView.addSubview(cellView)
    }

    private func setupLayout () {

        cellView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
        }

        infoview.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-94)
            make.height.equalTo(35)
        }

        infoStack.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
        }

        locationStack.snp.makeConstraints { make in
            make.top.equalTo(infoStack.snp.bottom).offset(2)
            make.leading.equalToSuperview()
        }

        exchangeRateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }

        rejectButton.snp.makeConstraints { make in
            make.top.equalTo(infoview.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(151.1)
            make.bottom.equalToSuperview().offset(-16)
        }
        acceptButton.snp.makeConstraints { make in
            make.top.equalTo(infoview.snp.bottom).offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.width.equalTo(151.1)
            make.height.equalTo(42)
            make.bottom.equalToSuperview().offset(-16)
        }
        starImage.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel.snp.centerY)
        }
        ratingLabel.snp.makeConstraints { make in
            make.centerY.equalTo(nameLabel.snp.centerY)
        }
    }
    
    // MARK: - Reuse

}
