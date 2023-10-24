//
//  VerificationPageViewController.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 02.07.2023.
//

import UIKit
import CHIOTPField
import ProgressHUD

final class VerificationPageViewController: UIViewController {
    
    private let service: OtpRegistrationService
    
    // MARK: - UI
    private let otpLabel: UILabel = {
        let label = UILabel()
        label.text = "Мы отправили письмо с кодом на ваш номер"
        label.textColor = AppColor.gray50.uiColor
        label.font = AppFont.regular.s14()
        return label
    }()
    
    private let otpCodeField: CHIOTPFieldOne = {
        let codeField = CHIOTPFieldOne()
        codeField.numberOfDigits = 6
        codeField.spacing = 8
        codeField.boxBackgroundColor = AppColor.gray10.uiColor
        codeField.borderColor = .clear
        codeField.cornerRadius = 8
        codeField.activeShadowColor = AppColor.primaryBase.uiColor
        codeField.textContentType = .oneTimeCode
        return codeField
    }()
    
    private let resendCodeLabel: UILabel = {
        let label = UILabel()
        label.text = "Еще не получили код подтверждения?"
        label.textColor = AppColor.gray100.uiColor
        label.numberOfLines = 0
        label.font = AppFont.regular.s14()
        label.textAlignment = .center
        return label
    }()
    
    private let resendCodeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Отправить код повторно", for: .normal)
        button.titleLabel?.font = AppFont.semibold.s14()
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.textColor = AppColor.primaryBase.uiColor
        return button
    }()
    
    private lazy var verifyButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = AppColor.primaryBase.uiColor
        button.setTitle("Подтвердить", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = AppFont.semibold.s16()
        button.addTarget(self, action: #selector(verifyButtonDidPress), for: .touchUpInside)
        button.layer.cornerRadius = 12.0
        return button
    }()
    
    // MARK: - Initializers
    init(service: OtpRegistrationService) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupViews()
        setupConstraints()
    }

    // MARK: - Setup Navigation Bar

    private func setupNavigationBar() {
        edgesForExtendedLayout = []
        self.navigationItem.title = "OTP"
        self.navigationItem.leftBarButtonItem =
        UIBarButtonItem(image: AppImage.arrow_back.uiImage,
                            style: .plain,
                            target: self,
                            action: #selector(backButtonDidPressed))
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = .white
        [otpLabel,otpCodeField, resendCodeLabel, resendCodeButton, verifyButton].forEach {
            view.addSubview($0)
        }
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        otpLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
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
        
        resendCodeButton.snp.makeConstraints { make in
            make.top.equalTo(resendCodeLabel).offset(15)
            make.leading.equalToSuperview().offset(104)
            make.trailing.equalToSuperview().offset(-104)
        }
        
        verifyButton.snp.makeConstraints { make in
            make.top.equalTo(resendCodeButton).offset(120)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(52)
        }
    }

    // MARK: - Actions
    @objc private func verifyButtonDidPress() {
        let code = otpCodeField.text ?? ""
        service.postOTPCode(with: code) { result in
            switch result {
            case .success:
                self.showSuccess()
                self.navigationController?.pushViewController(
                    RegistrationPersonalDataViewController(
                        service: self.service),
                        animated: true)
            case .failure:
                DispatchQueue.main.async {
                    self.showFailure()
                    self.showAlert(message: "Ошибка! Неверный код.")
                }
            }
        }
    }
    
    @objc private func backButtonDidPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - SnackBar
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Ошибка",
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK",
                                      style: .default,
                                      handler: {_ in }))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - ProgressHudProtocol
extension VerificationPageViewController: ProgressHudProtocol {
    func showSuccess() {
        ProgressHUD.show(icon: .succeed)
    }
    
    func showFailure() {
        ProgressHUD.show(icon: .failed)
    }
}
