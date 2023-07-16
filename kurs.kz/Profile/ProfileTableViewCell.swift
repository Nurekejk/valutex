//
//  ProfileTableViewCell.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 12.07.2023.
//

import UIKit
import SnapKit

final class ProfileTableViewCell: UITableViewCell {
    
    // MARK: - State
    static let reuseID = String(describing: ProfileTableViewCell.self)
    
    var profileSection: ProfileSection? {
        didSet {
            informationTypeImageView.image = UIImage(named: profileSection?.imageString ?? "")
            informationTypeLabel.text = profileSection?.name
        }
    }
    
    // MARK: - UI
    private lazy var informationTypeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bank")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var informationTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "Курс Нацбанка"
        label.textColor = UIColor(named: "infoTypeColor")
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        label.textAlignment = .left
        return label
    }()
    
     private lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "arrow-right")
        imageView.contentMode = .right
        return imageView
    }()
    
    private lazy var notificationImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "new-message")
        imageView.contentMode = .right
        return imageView
    }()
    
    private let informationCellStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .leading
        stack.distribution = .fill
        stack.spacing = 16
        return stack
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
        [informationTypeImageView, informationTypeLabel, notificationImageView, arrowImageView].forEach {
            informationCellStack.addArrangedSubview($0)
        }
        contentView.addSubview(informationCellStack)
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        informationCellStack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        informationTypeImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(24)
            make.width.equalTo(24)
        }
        
        informationTypeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
        }
        
        arrowImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
        }
        
        notificationImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(arrowImageView).offset(-24)
        }
    }
    
    // MARK: - Public
    public func configureCell(isBadgeHidden: Bool) {
        self.notificationImageView.isHidden = isBadgeHidden
    }

}
