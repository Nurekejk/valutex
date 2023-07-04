//
//  SelectCityViewController.swift
//  kurs.kz
//
//  Created by Nurbol on 04.07.2023.
//

import UIKit

final class SelectCityViewController: UIViewController {

    // MARK: - Outlets

    private let textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.placeholder = "Поиск"
        textField.font = .systemFont(ofSize: 14)
        textField.layer.cornerRadius = 8
        return textField
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "searchCity")
        return imageView
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        setupViews()
        setupConctraints()
    }

    // MARK: - Setup

    private func setupViews() {
        view.addSubview(textField)
        textField.addSubview(imageView)
        imageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        textField.leftView = imageView
        textField.leftViewMode = .always
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 48).isActive = true
        imageView.heightAnchor.constraint(equalTo: textField.heightAnchor).isActive = true
    }

    private func setupConctraints() {
        textField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(116)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(52)
        }
    }

}
