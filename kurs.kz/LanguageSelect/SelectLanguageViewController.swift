//
//  SelectLanguageViewController.swift
//  kurs.kz
//
//  Created by Bekzhan Askerbekov on 4/7/23.
//

import UIKit
import SnapKit

final class SelectLanguageViewController: UIViewController {
    
    // MARK: - UI

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = AppImage.select_language.uiImage
        return imageView
    }()

    private let label: UILabel = {
        let label = UILabel()
        label.text = "Выберите язык\nприложения"
        label.font = AppFont.bold.s24()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = AppColor.gray100.uiColor
        return label
    }()

    private lazy var kazakhButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Қазақша", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(AppColor.gray100.uiColor, for: .normal)
        button.titleLabel?.font = AppFont.bold.s20()
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 0.5
        button.layer.borderColor = AppColor.grayWhite.cgColor
        button.addTarget(self, action: #selector(kazakhButtonDidPress), for: .touchUpInside)
        return button
    }()

    private lazy var russianButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Русский", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(AppColor.gray100.uiColor, for: .normal)
        button.titleLabel?.font = AppFont.bold.s20()
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 0.5
        button.layer.borderColor = AppColor.grayWhite.cgColor
        button.addTarget(self, action: #selector(kazakhButtonDidPress), for: .touchUpInside)
        return button
    }()

    private lazy var englishButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("English", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(AppColor.gray100.uiColor, for: .normal)
        button.titleLabel?.font = AppFont.bold.s20()
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 1
        button.layer.borderColor = AppColor.grayWhite.cgColor
        button.addTarget(self, action: #selector(kazakhButtonDidPress), for: .touchUpInside)
        return button
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 30
        return stackView
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupViews()
        setupContraints()
    }

    // MARK: - Setup Views
    private func setupViews() {
        view.addSubview(imageView)
        view.addSubview(label)
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(kazakhButton)
        stackView.addArrangedSubview(russianButton)
        stackView.addArrangedSubview(englishButton)
    }

    // MARK: - Setup Constraints
    private func setupContraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(124)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(20)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        kazakhButton.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        russianButton.snp.makeConstraints { make in
            make.height.equalTo(kazakhButton)
        }
        
        englishButton.snp.makeConstraints { make in
            make.height.equalTo(kazakhButton)
        }
    }

    // MARK: - Actions

    @objc private func kazakhButtonDidPress() {
        let controller = MainPageViewController(service: <#SignInService#>)
        controller.navigationItem.hidesBackButton = true
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
