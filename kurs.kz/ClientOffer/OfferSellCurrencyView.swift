//
//  OfferSellCurrencyStack.swift
//  kurs.kz
//
//  Created by MacBook on 11.07.2023.
//

import UIKit

final class OfferSellCurrencyView: UIView {
    private let flagImageName: String
    private let currencyLabelText: String
    private let hasButton: Bool
    
    
    private let flagImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private let buttonView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let sumLabel: UILabel = {
        let currencySign: String
        let currencySum: String
        let label = UILabel()
        label.text = currencySum + "" + currencySign
        return label
    }()
    
    init(flagImageName: String, currencyText: String, hasButton: Bool) {
        self.currencyLabelText = currencyText
        self.hasButton = hasButton
        
        super.init(frame: .zero)
        
        configureView()
        configureSubviews()
        configureConstraints()
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
//        currencyLabel.font = .systemFont(ofSize: 16)
    }
    
    private func configureSubviews() {
        // Add and configure subviews (e.g., imageView, label) here
        addSubview(flagImageView)
        addSubview(currencyLabel)
        flagImageView.image = UIImage(named: flagImageName)
    }
    
    private func configureConstraints() {
        
        flagImageView.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.leading.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(116)
        }
        currencyLabel.snp.makeConstraints { make in
            make.leading.equalTo(flagImageView.snp.trailing).offset(16)
            make.top.equalToSuperview().offset(116)
        }
        buttonView.snp.makeConstraints { make in
            make.leading.equalTo(flagImageView.snp.trailing).offset(16)
            make.top.equalToSuperview().offset(116)
        }
        
        if hasButton {
            
        }
        
    }
}
