//
//  OfferSellViewController.swift
//  kurs.kz
//
//  Created by Adil on 11.07.2023.
//

import UIKit

final class OfferSellViewController: UIViewController {
    
    private let buttonBlueColor = UIColor(
        red: 45.0 / 255.0,
        green: 156.0 / 255.0,
        blue: 219.0 / 255.0,
        alpha: 1)
    
    private let borderGrayColor = UIColor(
        red: 232.0 / 255.0,
        green: 233.0 / 255.0,
        blue: 238.0 / 255.0,
        alpha: 1)
    
    private let backgroundGrayColor = UIColor(
        red: 246.0 / 255.0,
        green: 247.0 / 255.0,
        blue: 249.0 / 255.0,
        alpha: 1)
    
    private let textGrayColor = UIColor(
        red: 147.0 / 255.0,
        green: 153.0 / 255.0,
        blue: 171.0 / 255.0,
        alpha: 1)

    // MARK: - UI
    
    private let containerView: UIView = {
        let view = UIView()
        return view
    }()
    private let sellLabel: UILabel = {
        let label = UILabel()
        label.text = "Продать"
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        return label
    }()
    
    private let exchangeRateLabel: UILabel = {
        let label = UILabel()
        label.text = "По курсу"
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        return label
    }()
    
    let sellCurrencyView: OfferSellCurrencyView = {
        let currencyView = OfferSellCurrencyView(hasButton: true)
        return currencyView
    }()
    let exchangeRateCurrencyView: OfferSellCurrencyView = {
        let currencyView = OfferSellCurrencyView(hasButton: false)
        return currencyView
    }()
    
    let lowerBorderView: UIView = {
        let view = UIView()
        return view
    }()
    let getLabel: UILabel = {
        let label = UILabel()
        label.text = "Получить"
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        return label
    }()
    let getTotalLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    private lazy var resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = buttonBlueColor
        button.setTitle("Предложить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16.0, weight: .semibold)
        return button
    }()
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        containerView.layer.cornerRadius = 8
        sellCurrencyView.changeCurrency(newFlagImage: "usd_flag",
                                        newCurrencyLabel: "USD",
                                        newCurrencySignLabel: "$")
        exchangeRateCurrencyView.changeCurrency(newFlagImage: "kzt_flag",
                                                newCurrencyLabel: "KZT",
                                                newCurrencySignLabel: "₸" )
        sellCurrencyView.layer.borderWidth = 1
        sellCurrencyView.layer.borderColor = borderGrayColor.cgColor
        sellCurrencyView.layer.cornerRadius = 8
        exchangeRateCurrencyView.layer.borderWidth = 1
        exchangeRateCurrencyView.layer.borderColor = borderGrayColor.cgColor
        exchangeRateCurrencyView.layer.cornerRadius = 8
        
        sellLabel.textColor = textGrayColor
        exchangeRateLabel.textColor = textGrayColor
        getLabel.textColor = textGrayColor
        lowerBorderView.backgroundColor = borderGrayColor
        
        getTotalLabel.layer.cornerRadius = 8
        getTotalLabel.layer.borderWidth = 1
        getTotalLabel.layer.borderColor = borderGrayColor.cgColor
        getTotalLabel.backgroundColor = backgroundGrayColor
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = backgroundGrayColor
        sellLabel.textColor = borderGrayColor
        containerView.backgroundColor = .white
        
        view.addSubview(containerView)
        [sellCurrencyView,
         exchangeRateCurrencyView,
         sellLabel,
         exchangeRateLabel,
         lowerBorderView,
         getLabel,
         getTotalLabel].forEach { containerView.addSubview($0) }
    }
    // MARK: - Setup Constraints:
    private func setupConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.height.equalTo(430)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(116)
        }
        sellLabel.snp.makeConstraints { make in
            make.leading.equalTo(containerView.snp.leading).offset(16)
            make.top.equalTo(containerView.snp.top).offset(80)
            make.height.equalTo(18)
        }
        sellCurrencyView.snp.makeConstraints { make in
            make.top.equalTo(sellLabel.snp.bottom).offset(4)
            make.leading.equalTo(containerView.snp.leading).offset(16)
            make.height.equalTo(48)
            make.width.equalTo(311)
        }
        exchangeRateLabel.snp.makeConstraints { make in
            make.top.equalTo(sellCurrencyView.snp.bottom).offset(16)
            make.leading.equalTo(containerView.snp.leading).offset(16)
            make.height.equalTo(18)
        }
        exchangeRateCurrencyView.snp.makeConstraints { make in
            make.top.equalTo(exchangeRateLabel.snp.bottom).offset(4)
            make.leading.equalTo(containerView.snp.leading).offset(16)
            make.height.equalTo(48)
            make.width.equalTo(311)
        }
        lowerBorderView.snp.makeConstraints { make in
            make.top.equalTo(exchangeRateCurrencyView.snp.bottom).offset(16)
            make.leading.equalTo(containerView.snp.leading).offset(16)
            make.height.equalTo(1)
            make.width.equalTo(311)
        }
        getLabel.snp.makeConstraints { make in
            make.top.equalTo(lowerBorderView.snp.bottom).offset(16)
            make.leading.equalTo(containerView.snp.leading).offset(16)
            make.height.equalTo(18)
        }
        getTotalLabel.snp.makeConstraints { make in
            make.top.equalTo(getLabel.snp.bottom).offset(4)
            make.leading.equalTo(containerView.snp.leading).offset(16)
            make.height.equalTo(48)
            make.width.equalTo(311)
        }
    }
    // MARK: - Action
    //    @objc func changeStars(sender: UIButton!) {
    //        starButtons.forEach { $0.isSelected = false }
    //        for (index, element) in starButtons.enumerated() {
    //            starButtons[index].isSelected = true
    //            if element == sender {
    //                break
    //            }
    //        }
    //    }
    // }
    
    // MARK: - UITextViewDelegate
    // extension RateViewController {
    //
    //    func textViewDidBeginEditing(_ textView: UITextView) {
    //        if textView.textColor == UIColor.lightGray {
    //            textView.text = nil
    //            textView.textColor = UIColor.black
    //        }
    //    }
    //
    //    func textViewDidEndEditing(_ textView: UITextView) {
    //        if textView.text.isEmpty {
    //            textView.text = "Поделитесь мнением об обменнике ?"
    //            textView.textColor = UIColor.lightGray
    //        }
    //    }
    //
    //    func textView(_ textView: UITextView,
    //                  shouldChangeTextIn range: NSRange,
    //                  replacementText text: String) -> Bool {
    //        if (text == "\n") {
    //            textView.resignFirstResponder()
    //            return true
    //        }
    //        return true
    //    }
    // }
}
