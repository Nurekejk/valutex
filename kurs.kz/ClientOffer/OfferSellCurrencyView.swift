//
//  OfferSellCurrencyStack.swift
//  kurs.kz
//
//  Created by MacBook on 11.07.2023.
//

import UIKit

final class OfferSellCurrencyView: UIView {
    private let flagImageView: UIImageView
    private let currencyLabel: UILabel
    private let hasButton: Bool
    
    
    
    
    private let buttonView: UIView = {
        let view = UIView()
        return view
    }()
    
    init(flagImageName: String, currencyText: String, hasButton: Bool) {
        self.flagImageView = UIImageView(image: UIImage(named: flagImageName))
        self.currencyLabel = UILabel()
        self.hasButton = hasButton
        
        super.init(frame: .zero)
        
        configureView()
        configureSubviews()
        configureConstraints()
        
        currencyLabel.text = currencyText
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureView() {
        currencyLabel.font = .systemFont(ofSize: 16)
    }
    
    private func configureSubviews() {
        // Add and configure subviews (e.g., imageView, label) here
        addSubview(flagImageView)
        addSubview(currencyLabel)
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
