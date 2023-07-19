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
        imageView.image = UIImage(named: "onBoardingImage")
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text =
            "Предлагай свой курс на\n валюту и получай \n актуальные валютные \n курсы в твоем городе"
        label.font = .boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    private lazy var signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Войти", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        button.addTarget(self, action: #selector(signInButtonDidPress), for: .touchUpInside)
        return button
    }()

    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.borderColor = UIColor.blue.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 10
        button.setTitle("Зарегистрироватся", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(signUpButtonDidPress), for: .touchUpInside)
        return button
    }()

    private lazy var skipButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 10
        button.setTitle("Пропустить", for: .normal)
        button.setTitleColor(.gray, for: .normal)
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
            make.top.equalToSuperview().offset(124)
            make.leading.equalToSuperview().offset(45)
            make.trailing.equalToSuperview().offset(-45)
            make.height.equalTo(244)
        }

        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(64)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.centerX.equalToSuperview()
        }

        signInButton.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(52)
        }

        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(signInButton.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.height.equalTo(52)
        }

        skipButton.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom).offset(90)
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
        let controller = CustomTabBarViewController()
        controller.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
