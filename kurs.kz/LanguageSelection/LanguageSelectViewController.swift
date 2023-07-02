//
//  LanguageSelectViewController.swift
//  kurs.kz
//
//  Created by Bekzhan Askerbekov on 2/7/23.
//

import UIKit

class LanguageSelectViewController: UIViewController {
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Выберите язык приложения"
        label.translatesAutoresizingMaskIntoConstraints = false
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
        NSLayoutConstraint.activate([
//            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            label.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: -20),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

}
