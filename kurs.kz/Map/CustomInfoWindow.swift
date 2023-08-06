//
//  CustomInfoWindow.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 17.07.2023.
//

import UIKit

final class CustomInfoWindow: UIView {
    
    // MARK: - UI
    private lazy var exchangerNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Almaty"
        label.textColor = .black
        label.font = AppFont.semibold.s16()
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var exchangerDetailsLabel: UILabel = {
        let label = UILabel()
        label.text = "Almaty"
        label.textColor = .black
        label.font = AppFont.regular.s16()
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
        setupView()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        setupConstraints()
    }
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        self.layer.cornerRadius = 8.0
    }
    
    // MARK: - Setup View
    private func setupView() {
        backgroundColor = .white
        self.addSubview(exchangerNameLabel)
        self.addSubview(exchangerDetailsLabel)
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        exchangerNameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        exchangerDetailsLabel.snp.makeConstraints { make in
            make.top.equalTo(exchangerNameLabel.snp.bottom).offset(10)
            make.leading.equalToSuperview().offset(16)
            make.trailing.bottom.equalToSuperview().offset(-16)
        }
    }
    
    // MARK: - Public
    public func configureView(exchangerName name: String, exchangerSnippet details: String) {
        exchangerNameLabel.text = name
        exchangerDetailsLabel.text = details
    }
}
