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
        return label
    }()
    
    private let selectCurrencyButton: UIButton = {
        let button = UIButton()
        button.imageView?.image = UIImage(named: "down_arrow")
        return button
    }()
    
    private let borderView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let amountTextField: UITextField = {
        let textField = UITextField()
        return textField
    }()
    
    private let currencySignLabel: UILabel = {
        let label = UILabel()
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
//        self.addSubview(containerView)
        [flagImageView, currencyLabel,
         selectCurrencyButton, borderView,
         amountTextField, currencySignLabel].forEach {self.addSubview($0) }
        containerView.backgroundColor = .orange
        borderView.backgroundColor = .systemGray5
        selectCurrencyButton.backgroundColor = .red
        amountTextField.backgroundColor = .green
        if !hasButton {
            selectCurrencyButton.isHidden = true
        }
    }
    
    // MARK: - Setup Constraints:
    private func setupConstraints() {

        flagImageView.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(14)
        }
        currencyLabel.snp.makeConstraints { make in
            make.leading.equalTo(flagImageView.snp.trailing).offset(16)
            make.top.equalToSuperview().offset(14)
        }
        selectCurrencyButton.snp.makeConstraints { make in
            make.leading.equalTo(currencyLabel.snp.trailing).offset(16)
            make.top.equalToSuperview().offset(14)
            make.width.equalTo(9)
        }
        borderView.snp.makeConstraints { make in
            make.leading.equalTo(selectCurrencyButton.snp.trailing).offset(16)
            make.top.equalToSuperview().offset(14)
            make.height.equalTo(32)
            make.width.equalTo(1)
        }
        amountTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14)
            make.trailing.equalTo(currencySignLabel.snp.trailing).offset(-10)
            make.width.equalTo(100)
        }
        currencySignLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(14)
        }
    }
}
