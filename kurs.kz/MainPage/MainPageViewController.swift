//
//  MainPageViewController.swift
//  kurs.kz
//
//  Created by Diar Orynbek on 05.07.2023.
//

import UIKit
import SnapKit

class MainPageViewController: UIViewController {
  
  
  let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFit
    imageView.image = UIImage(named: "frame1")
    
    return imageView
  }()
  
  
  let label: UILabel = {
    let label = UILabel()
    label.text = "Предлагай свой курс на\n валюту и получай \n актуальные валютные \n курсы в твоем городе"
    label.font = .boldSystemFont(ofSize: 24)
    label.numberOfLines = 0
    label.textAlignment = .center
    return label
  }()
  
  
  let buttonLogIn: UIButton = {
    let button = UIButton()
    button.setTitle("Войти", for: .normal)
    button.backgroundColor = .blue
    button.layer.cornerRadius = 10
    
    return button
  }()
  
  
  let buttonRegister: UIButton = {
    let button = UIButton()
    button.setTitle("Зарегистрироватся", for: .normal)
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
    view.addSubview(imageView)
    view.addSubview(label)
    view.addSubview(buttonLogIn)
    view.addSubview(buttonRegister)
    
  }
  
  private func setupConstriants() {
    
    imageView.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(124)
      make.leading.equalToSuperview().offset(45)
      make.trailing.equalToSuperview().offset(-45)
      make.height.equalTo(244)
    }
    
    label.snp.makeConstraints { make in
      make.top.equalTo(imageView.snp.bottom).offset(64)
      make.leading.equalToSuperview().offset(24)
      make.trailing.equalToSuperview().offset(-24)
      make.centerX.equalToSuperview()
    }
    
    buttonLogIn.snp.makeConstraints { make in
      make.top.equalTo(label.snp.bottom).offset(32)
      make.leading.equalToSuperview().offset(24)
      make.trailing.equalToSuperview().offset(-24)
      make.height.equalTo(56)
    }
    
    buttonRegister.snp.makeConstraints { make in
      make.top.equalTo(buttonLogIn.snp.bottom).offset(12)
      make.leading.equalToSuperview().offset(24)
      make.trailing.equalToSuperview().offset(-24)
      make.height.equalTo(56)
    }
    
    
  }
  
}
