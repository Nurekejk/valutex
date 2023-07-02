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
        
    }

}
