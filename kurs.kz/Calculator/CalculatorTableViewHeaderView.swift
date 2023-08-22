//
//  CalculatorTableViewHeaderView.swift
//  kurs.kz
//
//  Created by Акерке on 19.07.2023.
//

import UIKit
import SnapKit
import PanModal

protocol CalculatorTableViewHeaderViewDelegate: AnyObject {
    func dropDownButtonDidPressed()
}

final class CalculatorTableViewHeaderView: UITableViewHeaderFooterView {
    weak var delegate: CalculatorTableViewHeaderViewDelegate?
    // MARK: - UI

    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    private lazy var flagImageLeft: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.kzt_flag.uiImage
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private lazy var currencyLabelLeft: UILabel = {
        let label = UILabel()
        label.text = "KZT"
        label.font = AppFont.regular.s16()
        return label
    }()
    private lazy var dropDownButtonLeft: UIButton = {
        let button = UIButton(type: .system)
        let iconImage = AppImage.down_arrow.uiImage
        button.setImage(iconImage, for: .normal)
        button.addTarget(self, action: #selector(dropDownButtonDidPressed),
                         for: .touchUpInside)
        return button
    }()
    private lazy var separatorLineImageLeft: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.separator_line.uiImage
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private lazy var arrowLeftRightButton: UIButton = {
        let button = UIButton(type: .system)
        let iconImage = AppImage.arrow_left_right.uiImage
        button.setImage(iconImage, for: .normal)
        button.addTarget(self, action: #selector(arrowLeftRightButtonDidPressed),
                         for: .touchUpInside)
        return button
    }()
    private lazy var separatorLineImageRight: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.separator_line.uiImage
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private lazy var flagImageRight: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.kzt_flag.uiImage
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private lazy var currencyLabelRight: UILabel = {
        let label = UILabel()
        label.text = "KZT"
        label.font = AppFont.regular.s16()
        return label
    }()
    private lazy var dropDownButtonRight: UIButton = {
        let button = UIButton(type: .system)
        let iconImage = AppImage.down_arrow.uiImage
        button.setImage(iconImage, for: .normal)
        button.addTarget(self, action: #selector(dropDownButtonDidPressed),
                         for: .touchUpInside)
        return button
    }()
    private lazy var currencyTextField: UITextField = {
        let textField = UITextField()
        textField.rightViewMode = .always
        textField.font = AppFont.regular.s16()
        textField.text = "500.00"
        return textField
    }()
    private lazy var clearButton: UIButton = {
        let button = UIButton(type: .system)
        let iconImage = AppImage.cross.uiImage
        button.setImage(iconImage, for: .normal)
        button.addTarget(self, action: #selector(clearButtonDidPressed),
                         for: .touchUpInside)
        return button
    }()
    private lazy var borderView: UIView = {
        let view = UIView()
        return view
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
    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.layer.cornerRadius = 8
    }

    // MARK: - Setup Views

    private func setupViews() {
        [flagImageLeft, currencyLabelLeft, dropDownButtonLeft, separatorLineImageLeft,
         arrowLeftRightButton, flagImageRight, currencyLabelRight, dropDownButtonRight,
         separatorLineImageRight, currencyTextField, clearButton, borderView].forEach {
            containerView.addSubview($0)
        }
        contentView.backgroundColor = AppColor.gray10.uiColor
        containerView.backgroundColor = AppColor.grayWhite.uiColor
        contentView.addSubview(containerView)
        containerView.addSubview(borderView)
        borderView.backgroundColor = AppColor.gray10.uiColor
    }

    // MARK: - Setup Constraints
    
    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-4) }
        borderView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalToSuperview().offset(45)
            make.leading.equalTo(containerView.snp.leading)
            make.trailing.equalTo(containerView.snp.trailing) }
        flagImageLeft.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16) }
        currencyLabelLeft.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14)
            make.leading.equalTo(flagImageLeft.snp.trailing).offset(16) }
        dropDownButtonLeft.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalTo(currencyLabelLeft.snp.trailing).offset(16) }
        separatorLineImageLeft.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalTo(dropDownButtonLeft.snp.trailing).offset(42) }
        arrowLeftRightButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalTo(separatorLineImageLeft.snp.trailing).offset(12) }
        separatorLineImageRight.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalTo(arrowLeftRightButton.snp.trailing).offset(12) }
        dropDownButtonRight.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-18.5) }
        currencyLabelRight.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14)
            make.trailing.equalTo(dropDownButtonRight.snp.leading).offset(-16) }
        flagImageRight.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.trailing.equalTo(currencyLabelRight.snp.leading).offset(-16) }
        currencyTextField.snp.makeConstraints { make in
            make.top.equalTo(flagImageLeft.snp.bottom).offset(26)
            make.leading.equalToSuperview().offset(16) }
        clearButton.snp.makeConstraints { make in
            make.top.equalTo(flagImageLeft.snp.bottom).offset(26)
            make.trailing.equalToSuperview().offset(-16) }
    }

    // MARK: - Actions

    @objc private func dropDownButtonDidPressed() {
        delegate?.dropDownButtonDidPressed()
    }
    @objc private func arrowLeftRightButtonDidPressed() {

    }
    @objc private func clearButtonDidPressed() {

    }
}
