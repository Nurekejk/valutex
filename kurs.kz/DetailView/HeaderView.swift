//
//  HeaderView.swift
//  kurs.kz
//
//  Created by Diar Orynbek on 22.07.2023.
//

import UIKit
import SnapKit

final class HeaderView: UITableViewHeaderFooterView {
    
    // MARK: - Public
    static let reusID = String(describing: HeaderView.self)
    
    // MARK: - UI
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Close", for: .normal)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "English"
        label.font = .boldSystemFont(ofSize: 16)
        return label
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
        
        [button].forEach {
            contentView.addSubview($0)
        }
    }
    
    // MARK: - Setup Constraitns
    func setupConstraints() {
        button.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(16)
        }
        
    }
    
    func setup(title: String) {
        titleLabel.text = title
    }
}
