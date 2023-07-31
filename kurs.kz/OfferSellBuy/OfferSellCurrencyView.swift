//
//  OfferSellCurrencyStack.swift
//  kurs.kz
//
//  Created by MacBook on 11.07.2023.
//

import UIKit

final class OfferSellCurrencyView: UIView {
    // MARK: - Static
    public func changeCurrency (newFlagImage: String,
                                newCurrencyLabel: String,
                                newCurrencySignLabel: String) {
        flagIconLabel.text = newFlagImage
        currencyLabel.text = newCurrencyLabel
        currencySignLabel.text = newCurrencySignLabel
    }
    
    // MARK: - Properties
    private let hasButton: Bool
    weak var delegate: OfferSellCurrencyViewDelegate?
    
    // MARK: - UI
    private let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let flagIconLabel: UILabel = {
        let imageView = UILabel()
        return imageView
    }()
    
    private let currencyLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.gray100.uiColor
        label.font = AppFont.regular.s16()
        return label
    }()
    
    private lazy var selectCurrencyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(AppImage.down_arrow.uiImage, for: .normal)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    private let borderView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColor.gray10.uiColor
        return view
    }()
    
    private lazy var amountTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = AppColor.primaryBase.uiColor
        textField.font = AppFont.semibold.s16()
        textField.textAlignment = .right
        textField.keyboardType = .decimalPad
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return textField
    }()
    
    private let currencySignLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.primaryBase.uiColor
        label.font = AppFont.semibold.s16()
        return label
    }()
    
    // MARK: - Initializers
    init(hasButton: Bool, tag: Int) {
        self.hasButton = hasButton
        super.init(frame: .zero)
        amountTextField.tag = tag
        setupViews()
        setupConstraints()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        self.addSubview(containerView)
        [flagIconLabel, currencyLabel,
         selectCurrencyButton, borderView,
         amountTextField, currencySignLabel].forEach {containerView.addSubview($0) }
        selectCurrencyButton.isHidden = !hasButton
    }
    
    // MARK: - Setup Constraints:
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        flagIconLabel.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.leading.equalTo(containerView.snp.leading).offset(16)
            make.top.equalTo(containerView.snp.top).offset(16)
        }
        currencyLabel.snp.makeConstraints { make in
            make.leading.equalTo(flagIconLabel.snp.trailing).offset(16)
            make.top.equalTo(containerView.snp.top).offset(14)
        }
        selectCurrencyButton.snp.makeConstraints { make in
            make.leading.equalTo(currencyLabel.snp.trailing).offset(12)
            make.top.equalTo(containerView.snp.top).offset(21.54)
            make.width.equalTo(9)
            make.height.equalTo(4.91)
        }
        borderView.snp.makeConstraints { make in
            make.leading.equalTo(selectCurrencyButton.snp.trailing).offset(16)
            make.top.equalTo(containerView.snp.top).offset(8)
            make.height.equalTo(32)
            make.width.equalTo(1)
        }
        amountTextField.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(14)
            make.trailing.equalTo(currencySignLabel.snp.leading).offset(-5)
            make.width.equalTo(105)
        }
        currencySignLabel.snp.makeConstraints { make in
            make.trailing.equalTo(containerView.snp.trailing).offset(-16)
            make.top.equalTo(containerView.snp.top).offset(14)
        }
    }
    // MARK: - Action
    @objc func buttonPressed(sender: UIButton!) {
        delegate?.selectorButtonPressed()
    }
    @objc func textFieldDidChange(sender: UITextField!) {
        delegate?.calculateOffer(sender: sender)
    }
}
    // MARK: - Protocols
protocol OfferSellCurrencyViewDelegate: AnyObject {
    func selectorButtonPressed()
    func calculateOffer(sender: UITextField)
}
