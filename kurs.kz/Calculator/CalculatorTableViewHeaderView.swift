//
//  CalculatorTableViewHeaderView.swift
//  kurs.kz
//
//  Created by Акерке on 19.07.2023.
//

import UIKit
import SnapKit
import PanModal

final class CalculatorTableViewHeaderView: UITableViewHeaderFooterView {
    // MARK: - Static
    static let identifier = String(describing: CalculatorTableViewHeaderView.self)
    
    weak var delegate: CalculatorTableViewHeaderViewDelegate?
    // MARK: - UI
    
    private lazy var gapView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    private let currencyImageLabelLeft: UILabel = {
        let label = UILabel()
        label.text = "🇰🇿"
        return label
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
        button.tag = 1
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
    private lazy var currencyImageLabelRight: UILabel = {
        let label = UILabel()
        label.text = "🇱🇷"
        return label
    }()
    private lazy var currencyLabelRight: UILabel = {
        let label = UILabel()
        label.text = "USD"
        label.font = AppFont.regular.s16()
        return label
    }()
    private lazy var dropDownButtonRight: UIButton = {
        let button = UIButton(type: .system)
        let iconImage = AppImage.down_arrow.uiImage
        button.setImage(iconImage, for: .normal)
        button.tag = 2
        button.addTarget(self, action: #selector(dropDownButtonDidPressed),
                         for: .touchUpInside)
        return button
    }()

    public lazy var currencyTextField: UITextField = {
        let textField = UITextField()
        textField.rightViewMode = .always
        textField.font = AppFont.regular.s16()
        textField.text = "500.00"
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        textField.keyboardType = .phonePad
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
        [currencyImageLabelLeft, currencyLabelLeft, dropDownButtonLeft, separatorLineImageLeft,
         arrowLeftRightButton, currencyImageLabelRight, currencyLabelRight, dropDownButtonRight,
         separatorLineImageRight, currencyTextField, clearButton, borderView].forEach {
            containerView.addSubview($0)
        }
        contentView.backgroundColor = AppColor.gray10.uiColor
        containerView.backgroundColor = AppColor.grayWhite.uiColor
        contentView.addSubview(gapView)
        contentView.addSubview(containerView)
        borderView.backgroundColor = AppColor.gray10.uiColor
    }
    
    // MARK: - Public
    public func makeLeftTenge() {
        currencyLabelLeft.text = "KZT"
        currencyImageLabelLeft.text = "🇰🇿"
    }
    
    public func makeRightTenge() {
        currencyLabelRight.text = "KZT"
        currencyImageLabelRight.text = "🇰🇿"
    }
    // swiftlint:disable all
    // MARK: - Setup Constraints
    
    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(96)
        }
        borderView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(containerView.snp.top).offset(45)
            make.leading.equalTo(containerView.snp.leading)
            make.trailing.equalTo(containerView.snp.trailing)
        }
        currencyImageLabelLeft.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(16)
            make.leading.equalTo(containerView.snp.leading).offset(16)
        }
        currencyLabelLeft.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(14)
            make.leading.equalTo(currencyImageLabelLeft.snp.trailing).offset(16)
        }
        dropDownButtonLeft.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(16)
            make.leading.equalTo(currencyLabelLeft.snp.trailing).offset(16)
        }
        separatorLineImageLeft.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(8)
            make.leading.equalTo(dropDownButtonLeft.snp.trailing).offset(42)
        }
        arrowLeftRightButton.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(16)
            make.leading.equalTo(separatorLineImageLeft.snp.trailing).offset(12)
        }
        separatorLineImageRight.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(8)
            make.leading.equalTo(arrowLeftRightButton.snp.trailing).offset(12)
        }
        dropDownButtonRight.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(16)
            make.trailing.equalTo(containerView.snp.trailing).offset(-18.5)
        }
        currencyLabelRight.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(14)
            make.trailing.equalTo(dropDownButtonRight.snp.leading).offset(-16)
        }
        currencyImageLabelRight.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(16)
            make.trailing.equalTo(currencyLabelRight.snp.leading).offset(-16)
        }
        currencyTextField.snp.makeConstraints { make in
            make.top.equalTo(currencyImageLabelLeft.snp.bottom).offset(26)
            make.leading.equalTo(containerView.snp.leading).offset(16)
        }
        clearButton.snp.makeConstraints { make in
            make.top.equalTo(currencyImageLabelLeft.snp.bottom).offset(26)
            make.trailing.equalTo(containerView.snp.trailing).offset(-16)
        }
        gapView.snp.makeConstraints { make in
            make.top.equalTo(containerView)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(24)
        }
    }

    // MARK: - Actions

    @objc private func dropDownButtonDidPressed(_ sender: UIButton) {
        delegate?.dropDownButtonDidPressed(position: ButtonPosition(rawValue: sender.tag) ?? .LEFT)
    }
    @objc private func textFieldDidChange() {
        delegate?.textfieldDidChange()
    }

    @objc func arrowLeftRightButtonDidPressed() {
        delegate?.swapButtonDidPress()
    }

    @objc private func clearButtonDidPressed() {
        currencyTextField.text = ""
    }

    // MARK: - Public
    // swiftlint:enable all
    public func updateCurrency(currency: Currency, position: ButtonPosition) {
        if position == .LEFT {
            currencyLabelLeft.text = currency.code
            currencyImageLabelLeft.text = currency.flag
        } else {
            currencyLabelRight.text = currency.code
            currencyImageLabelRight.text = currency.flag
        }
    }
}

protocol CalculatorTableViewHeaderViewDelegate: AnyObject {
    func dropDownButtonDidPressed(position: ButtonPosition)
    func textfieldDidChange()
    func swapButtonDidPress()
}
