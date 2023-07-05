//
//  ToSupportViewController.swift
//  kurs.kz
//
//  Created by Bekzhan Askerbekov on 5/7/23.
//

import UIKit
import SnapKit

final class ToSupportViewController: UIViewController {
    
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

    override func viewDidLoad() {
        super.viewDidLoad()

    }

}
