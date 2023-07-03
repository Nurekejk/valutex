//
//  LanguageSelectViewController.swift
//  kurs.kz
//
//  Created by Bekzhan Askerbekov on 2/7/23.
//

import UIKit
import SnapKit

class LanguageSelectViewController: UIViewController {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "selectlanguage")
        return imageView
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Выберите язык\nприложения"
        label.font = .boldSystemFont(ofSize: 24)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let kazakhButton: UIButton = {
        let button = UIButton()
        button.setTitle("Қазақша", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.black.cgColor
        return button
    }()
    
    let russianButton: UIButton = {
        let button = UIButton()
        button.setTitle("Русский", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.black.cgColor
        return button
    }()
    
    let englishButton: UIButton = {
        let button = UIButton()
        button.setTitle("English", for: .normal)
        button.backgroundColor = .white
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.black.cgColor
        return button
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 30
        return stackView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupViews()
        setupContraints()
    
    }
    
    private func setupViews() {
        view.addSubview(imageView)
        view.addSubview(label)
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(kazakhButton)
        stackView.addArrangedSubview(russianButton)
        stackView.addArrangedSubview(englishButton)
    }
    
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
}
