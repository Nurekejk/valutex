//
//  ExchangeListHeaderView.swift
//  kurs.kz
//
//  Created by MacBook on 18.07.2023.
//
import UIKit
import SnapKit

final class ExchangeListHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - State
    static let identifier = "ExchangeListTableCell"
    
    private let textGrayColor = UIColor(
        red: 147.0 / 255.0,
        green: 153.0 / 255.0,
        blue: 171.0 / 255.0,
        alpha: 1)
    
    // MARK: - UI
    private lazy var buyLabel: UILabel = {
        let label = UILabel()
        label.text = "Покупка"
        label.textColor = textGrayColor
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        return label
    }()
    private lazy var sellLabel: UILabel = {
        let label = UILabel()
        label.text = "Продажа"
        label.textColor = textGrayColor
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        return label
    }()
    private let upDownFilterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "up_down_filter"), for: .normal)
        return button
    }()
    private let downUpFilterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "down_up_filter"), for: .normal)
        return button
    }()
    
    // MARK: - Initializers
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = 8
        contentView.backgroundColor = .white
        contentView.layer.masksToBounds = true
        contentView.clipsToBounds = true
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0,
                                                                    left: 0,
                                                                    bottom: 4,
                                                                    right: 0))
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        [buyLabel, sellLabel,
         upDownFilterButton, downUpFilterButton].forEach {contentView.addSubview($0)}
        contentView.backgroundColor = .white
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        downUpFilterButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-12.5)
            make.size.equalTo(12)
        }
        sellLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(downUpFilterButton.snp.leading).offset(-4)
            make.height.equalTo(12)
        }
        upDownFilterButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(sellLabel.snp.leading).offset(-16.5)
            make.size.equalTo(12)
        }
        buyLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(upDownFilterButton.snp.leading).offset(-4)
            make.height.equalTo(12)
        }
    }
}