//
//  RegistrationPersonalDataViewController.swift
//  kurs.kz
//
//  Created by Adil on 02.07.2023.
//

import UIKit
import SnapKit

class RegistrationPersonalDataViewController: UIViewController {
    
    let surnameTextField: UITextField = {
        let textField = UITextField(frame: CGRect(x: 50, y: 100, width: 200, height: 30))
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter text"
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        view.backgroundColor = UIColor.red
        // Do any additional setup after loading the view.
    }
    
    func setupViews() {
        view.addSubview(surnameTextField)
    }
    
    
    private func setupConstraints() {
//        NSLayoutConstraint.activate([
//            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
////            label.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: -20),
////            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//        ])
//

        surnameTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.centerX.equalToSuperview()
//            make.centerX.equalToSuperview()
        }

    }
    


}
