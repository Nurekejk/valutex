//
//  OfferTableViewHeaderView.swift
//  kurs.kz
//
//  Created by Nurbol on 17.07.2023.
//

import UIKit
import SkyFloatingLabelTextField
import SnapKit

final class OfferTableViewHeaderView: UITableViewHeaderFooterView {
    // MARK: - Public
    public static var reuseIdentifier = String(describing: OfferTableViewHeaderView.self)
    private let service = OfferService()

    var changeButtonAction : ( ( ) -> Void)?

    // MARK: - UI
    private let containerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.layer.cornerRadius = 8
        return containerView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Заявка"
        label.font = AppFont.semibold.s16()
        label.textColor = AppColor.gray100.uiColor
        return label
    }()

    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Отменить", for: .normal)
        button.tintColor = AppColor.gray80.uiColor
        button.titleLabel?.font = AppFont.medium.s14()
        button.addTarget(self, action: #selector (cancelButtonDidPressed), for: .touchUpInside)
        return button
    }()

    private let firstContainerView: UIView = {
        let containerView = UIView()
        containerView.layer.cornerRadius = 8
        containerView.backgroundColor = AppColor.gray10.uiColor
        containerView.layer.borderColor = AppColor.gray20.uiColor.cgColor
        containerView.layer.borderWidth = 1
        return containerView
    }()
    private let secondContainerView: UIView = {
        let containerView = UIView()
        containerView.layer.cornerRadius = 8
        containerView.backgroundColor = AppColor.gray10.uiColor
        containerView.layer.borderColor = AppColor.gray20.uiColor.cgColor
        containerView.layer.borderWidth = 1
        return containerView
    }()

    private let firstLabel: UILabel = {
        let label = UILabel()
        label.text = "Продать"
        label.font = AppFont.regular.s12()
        label.textColor = AppColor.gray50.uiColor
        return label
    }()
    private let amountOfFirstLabel: UILabel = {
        let label = UILabel()
        label.text = "5 000"
        label.font = AppFont.regular.s16()
        label.textColor = AppColor.gray100.uiColor
        return label
    }()
    private let symbolOfFirstLabel: UILabel = {
        let label = UILabel()
        label.text = "$"
        label.font = AppFont.regular.s16()
        label.textColor = AppColor.gray100.uiColor
        return label
    }()

    private let secondLabel: UILabel = {
        let label = UILabel()
        label.text = "Получить"
        label.font = AppFont.regular.s12()
        label.textColor = AppColor.gray50.uiColor
        return label
    }()

    private let amountOfSecondLabel: UILabel = {
        let label = UILabel()
        label.text = "250 000"
        label.font = AppFont.regular.s16()
        label.textColor = AppColor.gray100.uiColor
        return label
    }()
    private let symbolOfSecondLabel: UILabel = {
        let label = UILabel()
        label.text = "₸"
        label.font = AppFont.regular.s16()
        label.textColor = AppColor.gray100.uiColor
        return label
    }()
    private let thirdContainerView: UIView = {
        let containerView = UIView()
        containerView.layer.cornerRadius = 8
        containerView.backgroundColor = AppColor.gray10.uiColor
        containerView.layer.borderColor = AppColor.gray20.uiColor.cgColor
        containerView.layer.borderWidth = 1
        return containerView
    }()
    private let thirdLabel: UILabel = {
        let label = UILabel()
        label.text = "По курсу"
        label.font = AppFont.regular.s12()
        label.textColor = AppColor.gray50.uiColor
        return label
    }()
    private let amountOfThirdLabel: UILabel = {
        let label = UILabel()
        label.text = "500"
        label.font = AppFont.regular.s16()
        label.textColor = AppColor.gray100.uiColor
        return label
    }()
    private let symbolOfThirdLabel: UILabel = {
        let label = UILabel()
        label.text = "₸"
        label.font = AppFont.regular.s16()
        label.textColor = AppColor.gray100.uiColor
        return label
    }()
    private lazy var changeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Изменить", for: .normal)
        button.tintColor = AppColor.primaryBase.uiColor
        button.titleLabel?.font = AppFont.medium.s14()
        button.addTarget(self,
                         action: #selector(changeButtonDidPressed),
                         for: .touchUpInside)
        return button
    }()

    // MARK: - Initializers
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
        [firstLabel, amountOfFirstLabel, symbolOfFirstLabel].forEach {
            firstContainerView.addSubview($0)
        }
        [secondLabel, amountOfSecondLabel, symbolOfSecondLabel].forEach {
            secondContainerView.addSubview($0)
        }
        [thirdLabel, amountOfThirdLabel, symbolOfThirdLabel, changeButton].forEach {
            thirdContainerView.addSubview($0)
        }
        [titleLabel, cancelButton, firstContainerView, secondContainerView, thirdContainerView].forEach {
            containerView.addSubview($0)
        }
        contentView.addSubview(containerView)
        contentView.backgroundColor =  AppColor.gray10.uiColor
    }
    // MARK: - Setup Constraints
    // swiftlint:disable all
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
            make.bottom.trailing.equalToSuperview().offset(-16)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
        }
        cancelButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(18)
        }
        firstContainerView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo((UIScreen.main.bounds.width - 80)/2)
            make.height.equalTo(56)
        }
        secondContainerView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.equalTo(firstContainerView.snp.trailing).offset(16)
            make.width.equalTo((UIScreen.main.bounds.width - 80)/2)
            make.height.equalTo(56)
        }
        [firstContainerView, secondContainerView].forEach {
            $0.snp.makeConstraints { make in
                make.top.equalTo(titleLabel.snp.bottom).offset(16)
                make.leading.equalTo(firstContainerView.snp.trailing).offset(16)
                make.width.equalTo((UIScreen.main.bounds.width - 80)/2)
                make.height.equalTo(56)
            }
        }
        [firstLabel, secondLabel, thirdLabel].forEach {
            $0.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(9.5)
                make.leading.equalToSuperview().offset(16)
                make.height.equalTo(16)
                make.width.equalTo(70)
            }
        }
        [amountOfFirstLabel, amountOfSecondLabel, amountOfThirdLabel].forEach {
            $0.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(25.5)
                make.leading.equalToSuperview().offset(16)
                make.height.equalTo(20)
            }
        }
        symbolOfFirstLabel.snp.makeConstraints { make in
            make.top.equalTo(firstLabel.snp.bottom)
            make.leading.equalTo(amountOfFirstLabel.snp.trailing).offset(5)
            make.height.equalTo(20)
        }
        symbolOfSecondLabel.snp.makeConstraints { make in
            make.top.equalTo(secondLabel.snp.bottom)
            make.leading.equalTo(amountOfSecondLabel.snp.trailing).offset(5)
            make.height.equalTo(20)
        }
        symbolOfThirdLabel.snp.makeConstraints { make in
            make.top.equalTo(thirdLabel.snp.bottom)
            make.leading.equalTo(amountOfThirdLabel.snp.trailing).offset(5)
            make.height.equalTo(20)
        }
        thirdContainerView.snp.makeConstraints { make in
            make.top.equalTo(firstContainerView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.bottom.equalToSuperview().offset(-16)
        }
        changeButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(19)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(18)
        }

    }
    // swiftlint:enable all
    @objc func changeButtonDidPressed() {
        changeButtonAction?()
    }
    @objc func cancelButtonDidPressed() {
        service.deleteOffer()

    }
}
