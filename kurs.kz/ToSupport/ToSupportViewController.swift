//
//  ToSupportViewController.swift
//  kurs.kz
//
//  Created by Bekzhan Askerbekov on 5/7/23.
//

import UIKit
import SnapKit

extension UIButton {
    func alignImageAndTitleVertically(padding: CGFloat = 6.0) {
        guard let imageView = self.imageView, let titleLabel = self.titleLabel else { return }
        let imageSize = imageView.frame.size
        let titleSize = titleLabel.bounds.size
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: -imageSize.width, bottom: -(imageSize.height + padding), right: 0)
        let titleWidth = max(0, titleSize.width - imageSize.width)
        self.imageEdgeInsets = UIEdgeInsets(top: -(imageSize.height + padding), left: 0, bottom: 0, right: -titleWidth)
        self.contentEdgeInsets = UIEdgeInsets(top: imageSize.height + padding, left: 0, bottom: 0, right: 0)
    }
}

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
        let button = UIButton(type: .system)
        button.setTitle("Telegram", for: .normal)
        button.setImage(UIImage(named: "telegram_icon")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.alignImageAndTitleVertically(padding: 11)
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 0.1
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        return button
    }()
    
    private let whatsappButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("WhatsApp", for: .normal)
        button.setImage(UIImage(named: "whatsapp_icon")?.withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.alignImageAndTitleVertically(padding: 11)
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 0.1
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        return button
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 0.5
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
               make.height.equalTo(50)
           }
           
           whatsappButton.snp.makeConstraints { make in
               make.height.equalTo(telegramButton)
           }
       }
   }
