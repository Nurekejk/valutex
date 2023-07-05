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
       label.font = .boldSystemFont(ofSize: 24)
       label.textAlignment = .center
       return label
    }()
    
    private let telegramButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Telegram", for: .normal)
        button.setImage(UIImage(named: "telegram_icon"), for: .normal)
        button.tintColor = .black
        button.imageView?.contentMode = .scaleAspectFit
        button.backgroundColor = .white
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return button
    }()

    // MARK: lifecicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white

    }
    
    // MARK: Setup View
    
    private func setupView() {
        
    }
    
    // MARK: Setup Constraints
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.trailing.equalToSuperview()
        }
    }
}
