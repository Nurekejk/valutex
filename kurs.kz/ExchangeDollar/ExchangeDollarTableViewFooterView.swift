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
    
    private lazy var titleOneLabel: UILabel = {
        let label = UILabel()
        label.text = "Еще"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .blue
        
        return label
    }()
    
    // MARK: - Life Cycle
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstriats()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    
    func setupViews() {
        
        contentView.addSubview(titleOneLabel)
    }
    
    // MARK: - Setup Constraits
    
    func setupConstriats() {
        
        titleOneLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-16)
        }
    }
}
