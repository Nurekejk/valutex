//
//  ExchangeDollarTableViewFooterView.swift
//  kurs.kz
//
//  Created by Diar Orynbek on 14.07.2023.
//

import UIKit
import SnapKit

final class ExchangeDollarTableViewFooterView: UITableViewHeaderFooterView {
    
    // MARK: - UI
    let backgroundBlueColor = UIColor(
        red: 45 / 255.0,
        green: 156 / 255.0,
        blue: 219 / 255.0,
        alpha: 1
    )
    
    private lazy var titleOneLabel: UILabel = {
        let label = UILabel()
        label.text = "Еще"
        label.font = AppFont.bold.s14()
        label.textColor = backgroundBlueColor
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Еще", for: .normal)
        return button
    }()
    
    // MARK: - Life Cycle
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    func setupViews() {
        contentView.backgroundColor = .white
        contentView.addSubview(button)
    }
    
    // MARK: - Setup Constraints
    func setupConstraints() {
        button.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
}
