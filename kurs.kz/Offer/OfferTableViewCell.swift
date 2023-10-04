//
//  OfferTableViewCell.swift
//  kurs.kz
//
//  Created by Nurbol on 09.07.2023.
//

import UIKit

final class OfferTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    weak var delegate: OfferTableViewCellDelegate?
    private var offerResponse: OfferResponseForTableView?
    private var index = 0

    // MARK: - Public
    public static var reuseIdentifier = String(describing: OfferTableViewCell.self)

    // MARK: - UI
    private let cellView: UIView = {
        let cellView = UIView()
        cellView.backgroundColor = .white
        return cellView
    }()

    private let infoview: UIView = {
        let infoview = UIView()
        infoview.backgroundColor = .white
        return infoview
    }()

    private let infoStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
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
        label.font = AppFont.regular.s14()
        return label
    }()

    private let starImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.image = AppImage.star12.uiImage
        return image
    }()

    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "5 (15)"
        label.font = AppFont.regular.s12()
        return label
    }()

    private let locationLabel: UILabel = {
        let label = UILabel()
        label.text = "г.Алматы, ул. Ауэзова 14"
        label.font = AppFont.regular.s14()
        return label
    }()

    private let distanceLabel: UILabel = {
        let label = UILabel()
        label.text = "(1 км)"
        label.font = AppFont.regular.s14()
        return label
    }()

    private let exchangeRateLabel: UILabel = {
        let label = UILabel()
        label.text = "505 ₸"
        label.font = AppFont.semibold.s14()
        return label
    }()

    private lazy var rejectButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(rejectButtonPressed), for: .touchUpInside)
        button.setTitle("Отклонить", for: .normal)
        button.tintColor = .red
        button.backgroundColor = UIColor(red: 0.96, green: 0.97, blue: 0.98, alpha: 1.0)
        button.titleLabel?.font = AppFont.regular.s14()
        return button
    }()

    private lazy var acceptButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(acceptButtonPressed), for: .touchUpInside)
        button.setTitle("Принять", for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(red: 45/255, green: 156/255, blue: 219/255, alpha: 1)
        button.titleLabel?.font = AppFont.regular.s14()
        return button
    }()

    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        cellView.layer.cornerRadius = 8
        rejectButton.layer.cornerRadius = 8
        acceptButton.layer.cornerRadius = 8
    }
    
    // MARK: - Action
    public func setupCell(with offer: OfferResponseForTableView, index: Int) {
        offerResponse = offer
        self.index = index
        
        nameLabel.text = offer.officeName
        if let score = offer.score, let scoreCount = offer.scoreCount {
            ratingLabel.text = "\(score) (\(scoreCount))"
        }
        locationLabel.text = offer.officeAddress
        if let exchangeRate = offer.exchangeRate {
            exchangeRateLabel.text = String(exchangeRate)
        }
    }
    
    @objc func rejectButtonPressed() {
        if let id = offerResponse?.offerResponseId {
            print("herererere")
            delegate?.rejectDidPress(offerResponseId: id)
        }
    }
    
    @objc func acceptButtonPressed() {
        if let id = offerResponse?.offerResponseId {
            delegate?.acceptDidPress(offerResponseId: id, index: index)
        }
    }

    // MARK: - Setup Views
    private func setupHierarchy() {
        [nameLabel, starImage, ratingLabel].forEach {
            infoStack.addArrangedSubview($0)
        }
        [locationLabel, distanceLabel].forEach {
            locationStack.addArrangedSubview($0)
        }
        [infoStack, locationStack].forEach {
            infoview.addSubview($0)
        }
        [infoview, exchangeRateLabel, rejectButton, acceptButton].forEach {
            cellView.addSubview($0)
        }
        contentView.backgroundColor = AppColor.gray10.uiColor
        contentView.addSubview(cellView)
    }

    private func setupConstraints() {
        cellView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(125)
        }

        infoview.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
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
            make.trailing.bottom.equalToSuperview().offset(-16)
            make.width.equalTo(151.1)
        }
    }
}

protocol OfferTableViewCellDelegate: AnyObject {
    func acceptDidPress(offerResponseId: Int, index: Int)
    func rejectDidPress(offerResponseId: Int)
}
