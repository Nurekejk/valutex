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
    
    private let borderGrayColor = CGColor(
        red: 232.0 / 255.0,
        green: 233.0 / 255.0,
        blue: 238.0 / 255.0,
        alpha: 1)
    
    private let backgroundGrayColor = UIColor(
        red: 246.0 / 255.0,
        green: 247.0 / 255.0,
        blue: 249.0 / 255.0,
        alpha: 1)
    
    // MARK: - UI
    
    private let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    let sellCurrencyView: OfferSellCurrencyView = {
        let currencyView = OfferSellCurrencyView(hasButton: true)
        return currencyView
    }()
    let exchangeRateCurrencyView: OfferSellCurrencyView = {
        let currencyView = OfferSellCurrencyView(hasButton: false)
        return currencyView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        sellCurrencyView.changeCurrency(newFlagImage: "usd_flag",
                                        newCurrencyLabel: "USD",
                                        newCurrencySignLabel: "$")
//        reviewTextView.layer.cornerRadius = 8
//        reviewTextView.layer.borderWidth = 1
//        reviewTextView.layer.borderColor = borderGrayColor
//        continueButton.layer.cornerRadius = 12
//        entireStackView.layer.cornerRadius = 8
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        
        view.addSubview(containerView)
        containerView.addSubview(sellCurrencyView)
        containerView.addSubview(exchangeRateCurrencyView)
        containerView.backgroundColor = .cyan
    }
    
    // MARK: - Setup Constraints:
    private func setupConstraints() {
        
        containerView.snp.makeConstraints { make in
            make.height.equalTo(430)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.top.equalToSuperview().offset(116)
        }
        sellCurrencyView.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.width.equalTo(311)
        }
//        borderView.snp.makeConstraints { make in
//            make.height.equalTo(1)
//            make.leading.equalTo(entireStackView.snp.leading)
//            make.trailing.equalTo(entireStackView.snp.trailing)
//        }
//        reviewLabel.snp.makeConstraints { make in
//            make.height.equalTo(18)
//        }
//        reviewTextView.snp.makeConstraints { make in
//            make.height.equalTo(120)
//            make.leading.equalTo(entireStackView.snp.leading).offset(16)
//            make.trailing.equalTo(entireStackView.snp.trailing).offset(-16)
//        }
//        continueButton.snp.makeConstraints { make in
//            make.height.equalTo(52)
//            make.leading.equalTo(entireStackView.snp.leading).offset(16)
//            make.trailing.equalTo(entireStackView.snp.trailing).offset(-16)
//        }
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
