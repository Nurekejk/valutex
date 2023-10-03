//
//  MainPageViewController.swift
//  kurs.kz
//
//  Created by Diar Orynbek on 05.07.2023.
//

import UIKit
import SnapKit

final class MainPageViewController: UIViewController {
    
    // MARK: - UI
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = AppImage.on_boarding_image.uiImage
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text =
            "Предлагай свой курс на\n валюту и получай \n актуальные валютные \n курсы в твоем городе"
        label.font = AppFont.bold.s24()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = AppColor.gray100.uiColor
        return label
    }()

    private lazy var signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = AppFont.semibold.s16()
        button.backgroundColor = AppColor.primaryBase.uiColor
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(signInButtonDidPress), for: .touchUpInside)
        return button
    }()

    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.borderColor = AppColor.primaryBase.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.setTitle("Зарегистрироватся", for: .normal)
        button.setTitleColor(AppColor.primaryBase.uiColor, for: .normal)
        button.titleLabel?.font = AppFont.semibold.s16()
        button.addTarget(self, action: #selector(signUpButtonDidPress), for: .touchUpInside)
        return button
    }()

    private lazy var skipButton: UIButton = {
        let button = UIButton(type: .system)
        let title = "Пропустить"
        
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: AppColor.gray50.uiColor,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        
        let attributedTitle = NSAttributedString(string: title, attributes: attributes)
        
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(skipButtonDidPress), for: .touchUpInside)
        return button
    }()
    // MARK: - Lifecyle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstriants()
    }

    // MARK: - Setup Views"
    private func setupViews() {
        view.backgroundColor = .white

        [imageView, titleLabel, signInButton, signUpButton, skipButton].forEach {
            view.addSubview($0)
        }
    }

    // MARK: - Setup Constraints"
    private func setupConstriants() {
        imageView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(24)
            make.leading.equalToSuperview().offset(45)
            make.trailing.equalToSuperview().offset(-45)
            make.height.equalTo(244)
        }

        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(signInButton.snp.top).offset(-32)
        }

        signInButton.snp.makeConstraints { make in
            make.bottom.equalTo(signUpButton.snp.top).offset(-12)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(52)
        }

        signUpButton.snp.makeConstraints { make in
            make.bottom.equalTo(skipButton.snp.top).offset(-24)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(52)
        }

        skipButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(20)
        }
    }

    // MARK: Actions
    @objc private func signInButtonDidPress() {
        self.navigationController?.pushViewController(SignInViewController(), animated: true)
    }

    @objc private func signUpButtonDidPress() {
        self.navigationController?.pushViewController(SignUpViewController(), animated: true)
    }

    @objc private func skipButtonDidPress() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: SignInViewController.defaultsUserAndTokensKey)
        let controller = MainTabBarViewController(service: TabBarService())
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true)
    }
}
