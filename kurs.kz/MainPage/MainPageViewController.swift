//
//  MainPageViewController.swift
//  kurs.kz
//
//  Created by Diar Orynbek on 05.07.2023.
//

import UIKit
import SnapKit

class MainPageViewController: UIViewController {
  
  
  let label: UILabel = {
    let label = UILabel()
    label.text = "Вход"
    label.font = .boldSystemFont(ofSize: 28)
    
    return label
  }()
  
  
  let phoneTextField: UITextField = {
    let textField = UITextField()
    textField.placeholder = "Телефон"
    textField.layer.borderColor = UIColor.gray.cgColor
    textField.layer.borderWidth = 1
    
    
    return textField
  }()
  
  
  let passwordTextField: UITextField = {
    let textField = UITextField()
    textField.placeholder = "Пароль"
    textField.layer.borderColor = UIColor.gray.cgColor
    textField.layer.borderWidth = 1
    
    
    return textField
  }()
  
  
  let button: UIButton = {
    let button = UIButton()
    button.setTitle("Log in", for: .normal)
    button.backgroundColor = .blue
    button.layer.cornerRadius = 10
    
    return button
  }()
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .white
    
    setupViews()
    setupConstriants()
  }
  
  private func setupViews() {
    view.addSubview(label)
    view.addSubview(phoneTextField)
    view.addSubview(passwordTextField)
    view.addSubview(button)
  }
  
  private func setupConstriants() {
    
    label.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(100)
      make.centerX.equalToSuperview()
      
    }
    
    phoneTextField.snp.makeConstraints { make in
      make.top.equalTo(label.snp.bottom).offset(24)
      make.leading.equalToSuperview().offset(24)
      make.trailing.equalToSuperview().offset(-24)
      make.height.equalTo(56)
    }
    
    passwordTextField.snp.makeConstraints { make in
      make.top.equalTo(phoneTextField.snp.bottom).offset(24)
      make.leading.equalToSuperview().offset(24)
      make.trailing.equalToSuperview().offset(-24)
      make.height.equalTo(56)
    }
    
    button.snp.makeConstraints { make in
      make.top.equalTo(passwordTextField.snp.bottom).offset(100)
      make.leading.equalToSuperview().offset(24)
      make.trailing.equalToSuperview().offset(-24)
      make.height.equalTo(56)
      
    }
  }
  
}
