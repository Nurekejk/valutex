//
//  OfferSellCurrencyStack.swift
//  kurs.kz
//
//  Created by MacBook on 11.07.2023.
//

import UIKit
import PanModal

final class OfferSellCurrencyView: UIView {
    // MARK: - Static
    
    weak var delegate: OfferSellCurrencyViewDelegate?
    
    public let amountTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = .blue
        textField.textAlignment = .right
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    func changeCurrency (newFlagImage: String,
                         newCurrencyLabel: String,
                         newCurrencySignLabel: String) {
        flagImageView.image = UIImage(named: newFlagImage)
        currencyLabel.text = newCurrencyLabel
        currencySignLabel.text = newCurrencySignLabel
    }
    
    private let hasButton: Bool
    
    // MARK: - UI
    private let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let flagImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let currencyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        return label
    }()
    
    private lazy var selectCurrencyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "down_arrow"), for: .normal)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    private let borderView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let currencySignLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blue
        return label
    }()
    
    // MARK: - Initializers
    init(hasButton: Bool) {
        self.hasButton = hasButton
        
        super.init(frame: .zero)
        setupViews()
        setupConstraints()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        self.addSubview(containerView)
        [flagImageView, currencyLabel,
         selectCurrencyButton, borderView,
         amountTextField, currencySignLabel].forEach {containerView.addSubview($0) }
        borderView.backgroundColor = .systemGray5
        selectCurrencyButton.isHidden = !hasButton
    }
    
    // MARK: - Setup Constraints:
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        flagImageView.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.leading.equalTo(containerView.snp.leading).offset(16)
            make.top.equalTo(containerView.snp.top).offset(16)
        }
        currencyLabel.snp.makeConstraints { make in
            make.leading.equalTo(flagImageView.snp.trailing).offset(16)
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
}
protocol OfferSellCurrencyViewDelegate: AnyObject {
    func selectorButtonPressed()
}
