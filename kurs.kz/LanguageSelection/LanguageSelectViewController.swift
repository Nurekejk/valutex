//
//  LanguageSelectViewController.swift
//  kurs.kz
//
//  Created by Bekzhan Askerbekov on 2/7/23.
//

import UIKit
import SnapKit

class LanguageSelectViewController: UIViewController {
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Выберите язык приложения"
        label.font = .boldSystemFont(ofSize: 24)
//        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupViews()
        setupConstraints()
        
    }
    
    private func setupViews() {
        view.addSubview(label)
    }
    
    private func setupConstraints() {
//        NSLayoutConstraint.activate([
//            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            label.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: -20),
//            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//        ])
        
        label.snp.makeConstraints { make in
//            make.leading.equalToSuperview().offset(24)
            make.top.equalToSuperview().offset(292)
            make.centerX.equalToSuperview()
            
            
        }
    }
}
