//
//  AcceptedSendTableViewCell.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 16.07.2023.
//

import UIKit
import SnapKit

final class AcceptedSendTableViewCell: UITableViewCell {
    
    // MARK: - State
    static let reuseID = String(describing: AcceptedSendTableViewCell.self)
    
    // MARK: - UI
    private lazy var acceptedSendImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "accepted-image")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var acceptedSendCellStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 16
        return stackView
    }()
    
    private lazy var acceptedSendLabel: UILabel = {
        let label = UILabel()
        label.text = "Принятые (2)"
        label.textColor = UIColor(named: "partnerOfferBasicTextColor")
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private lazy var arrowRightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "arrow-right")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        contentView.addSubview(acceptedSendCellStackView)
        
        [acceptedSendImageView, acceptedSendLabel, arrowRightImageView].forEach {
            acceptedSendCellStackView.addArrangedSubview($0)
        }
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        acceptedSendCellStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        acceptedSendImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(48)
            make.width.equalTo(50)
        }
        
        acceptedSendLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
        }
        
        arrowRightImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(16)
            make.width.equalTo(16)
        }
    }
}
