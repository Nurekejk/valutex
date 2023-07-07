//
//  MainPageViewController.swift
//  kurs.kz
//
//  Created by Diar Orynbek on 05.07.2023.
//

import UIKit
import SnapKit

class MainPageViewController: UIViewController {
  
  
  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.image = UIImage(named: "onBoardingImage")
    
    return imageView
  }()
  
  
  private let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "Предлагай свой курс на\n валюту и получай \n актуальные валютные \n курсы в твоем городе"
    label.font = .boldSystemFont(ofSize: 24)
    label.numberOfLines = 0
    label.textAlignment = .center
    return label
  }()
  
  
  private let logInButton: UIButton = {
    let button = UIButton()
    button.setTitle("Войти", for: .normal)
    button.backgroundColor = .blue
    button.layer.cornerRadius = 10
    
    return button
  }()
  
  
  private let registerButton: UIButton = {
    let button = UIButton(type: .system)
    button.layer.borderColor = UIColor.blue.cgColor
    button.layer.borderWidth = 1
    button.layer.cornerRadius = 10
    button.setTitle("Зарегистрироватся", for: .normal)
    button.setTitleColor(.blue, for: .normal)
    
    return button
  }()
  
  
  private let nextButton: UIButton = {
    let button = UIButton()
    button.layer.cornerRadius = 10
    button.setTitle("Пропустить", for: .normal)
    button.setTitleColor(.gray, for: .normal)
    
    return button
  }()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViews()
    setupConstriants()
  }
  
  // MARK: - Setup Views:"
  
  private func setupViews() {
    view.backgroundColor = .white
    
    [imageView, titleLabel, logInButton, registerButton, nextButton].forEach {view.addSubview($0)}
  }
  
  // MARK: - Setup Constraints:"
  
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
    
    logInButton.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(32)
      make.leading.equalToSuperview().offset(24)
      make.trailing.equalToSuperview().offset(-24)
      make.height.equalTo(52)
    }
    
    registerButton.snp.makeConstraints { make in
      make.top.equalTo(logInButton.snp.bottom).offset(12)
      make.leading.equalToSuperview().offset(24)
      make.trailing.equalToSuperview().offset(-24)
      make.height.equalTo(52)
    }
    
    nextButton.snp.makeConstraints { make in
      make.top.equalTo(registerButton.snp.bottom).offset(90)
      make.leading.equalToSuperview().offset(24)
      make.trailing.equalToSuperview().offset(-24)
      make.height.equalTo(20)
    }
  }
}
