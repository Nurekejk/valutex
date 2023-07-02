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
        label.text = "Выберите язык приложения"
        label.font = .boldSystemFont(ofSize: 24)
        return label
    }()
    
    let kazakhButton: UIButton = {
        let button = UIButton()
        button.setTitle("Қазақша", for: .normal)
        button.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        button.tintColor = .white
        button.layer.cornerRadius = 10
        return button
    }()
    
    let russianButton: UIButton = {
        let button = UIButton()
        button.setTitle("Қазақша", for: .normal)
        button.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        button.tintColor = .white
        button.layer.cornerRadius = 10
        return button
    }()
    
    let englishButton: UIButton = {
        let button = UIButton()
        button.setTitle("Қазақша", for: .normal)
        button.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        button.tintColor = .white
        button.layer.cornerRadius = 10
        return button
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 10
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
        
    }
    
    private func setupContraints() {
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(50)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(300)
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
        }
    }
}
