//
//  VerificationPageViewController.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 02.07.2023.
//

import UIKit
import CHIOTPField

final class VerificationPageViewController: UIViewController {
    
    // MARK: - UI
    private let otpLabel: UILabel = {
        let label = UILabel()
        label.text = "Мы отправили письмо с кодом на ваш номер"
        label.textColor = UIColor(named: "selectedTitleColor")
        label.font = UIFont.systemFont(ofSize: 14.0)
        return label
    }()
    
    private let otpCodeField: CHIOTPFieldOne = {
        let codeField = CHIOTPFieldOne()
        codeField.numberOfDigits = 6
        codeField.spacing = 8
        codeField.boxBackgroundColor = UIColor(named: "otpCodeFieldBoxColor")!
        codeField.borderColor = .clear
        codeField.cornerRadius = 8
        codeField.activeShadowColor = UIColor(named: "otpCodeFieldActiveShadowColor")
        return codeField
    }()
    
    private let resendCodeLabel: UILabel = {
        let label = UILabel()
        label.text = "Еще не получили код подтверждения?\nОтправить код повторно"
        label.textColor = UIColor(named: "resendCodeTextColor")
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.textAlignment = .center
        return label
    }()
    
    private let verifyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(named: "verifyButtonColor")
        button.setTitle("Подтвердить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12.0
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(otpLabel)
        view.addSubview(otpCodeField)
        view.addSubview(resendCodeLabel)
        view.addSubview(verifyButton)
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        otpLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(116)
            make.centerX.equalToSuperview()
        }
        
        otpCodeField.snp.makeConstraints { make in
            make.top.equalTo(otpLabel).offset(32)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(70)
        }
        
        resendCodeLabel.snp.makeConstraints { make in
            make.top.equalTo(otpLabel).offset(134)
            make.centerX.equalToSuperview()
        }
        
        verifyButton.snp.makeConstraints { make in
            make.top.equalTo(resendCodeLabel).offset(120)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(52)
        }
    }
    
    // MARK: - Actions
        
        @objc private func verifyButtonDidPressed() {
            self.navigationController?.pushViewController(VerificationPageViewController(), animated: true)
        }
    

}
