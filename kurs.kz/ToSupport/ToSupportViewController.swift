//
//  ToSupportViewController.swift
//  kurs.kz
//
//  Created by Bekzhan Askerbekov on 5/7/23.
//
import UIKit
import SnapKit

final class ToSupportViewController: UIViewController {
    
    // MARK: UI
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Написать в поддержу"
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    
    private let telegramButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "telegram_icon"), for: .normal)
        button.setTitle("Telegram", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        button.contentHorizontalAlignment = .left
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 0.1
        return button
    }()
    
    private let whatsappButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "whatsapp_icon"), for: .normal)
        button.setTitle("WhatsApp", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        button.contentHorizontalAlignment = .left
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 0.1
        
        return button
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 0.3
        return stackView
    }()
    
    // MARK: Lifecicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
        setupConstraints()
    }
    
    // MARK: Setup View
    
    private func setupView() {
        view.addSubview(titleLabel)
        view.addSubview(stackView)
        stackView.addArrangedSubview(telegramButton)
        stackView.addArrangedSubview(whatsappButton)
    }
    
    // MARK: Setup Constraints
    private func setupConstraints() {
           titleLabel.snp.makeConstraints { make in
               make.top.equalToSuperview().offset(62)
               make.leading.trailing.equalToSuperview()
           }
           
           stackView.snp.makeConstraints { make in
               make.top.equalTo(titleLabel.snp.bottom).offset(20)
               make.leading.equalToSuperview().offset(20)
               make.trailing.equalToSuperview().offset(-20)
           }
           
           telegramButton.snp.makeConstraints { make in
               make.height.equalTo(54)
               make.leading.equalToSuperview().offset(10)
           }
           
           whatsappButton.snp.makeConstraints { make in
               make.height.equalTo(telegramButton)
           }
       }
   }
