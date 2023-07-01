//
//  RegistrationPersonalDataViewController.swift
//  kurs.kz
//
//  Created by Adil on 01.07.2023.
//

import Foundation

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
        setup()
        setupLayout()
        view.backgroundColor = UIColor.red
        // Do any additional setup after loading the view.
    }
    
    func setup() {
        
        
        
        view.addSubview(surnameTextField)
    }
    
    func setupLayout() {
        surnameTextField.snp.makeConstraints { make in
//            make.width.height.equalTo(50)
//            make.center.equalTo(self.view)
        }
        
    }
    


}
