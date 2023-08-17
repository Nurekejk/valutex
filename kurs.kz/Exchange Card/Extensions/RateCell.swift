//
//  RateCell.swift
//  kurs.kz
//
//  Created by Diar Orynbek on 16.08.2023.
//

import UIKit
import SnapKit

final class RateCell: UITableViewCell {
    
    // MARK: - Public
    static let reuseID = String(describing: RateCell.self)
    
    // MARK: - State
    private let rateService = RateService()
    
    // MARK: - UI
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    private lazy var starsLabel: UILabel = {
        let label = UILabel()
        label.text = "count stars"
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    private lazy var subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Все отлично!"
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "25.02.2023"
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .right
        return label
    }()
    
    // MARK: - Life Cycle
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
        [nameLabel, subTitleLabel, dateLabel, starsLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(32)
            make.height.equalTo(18)
            make.width.equalTo(215)
        }
        
        starsLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-32)
            make.height.equalTo(16)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(32)
            make.height.equalTo(18)
            make.width.equalTo(311)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom).offset(8)
            make.trailing.equalToSuperview().offset(-32)
            make.height.equalTo(18)
        }
    }
    
    func setup(rate: Rate) {
        nameLabel.text = rate.fullName
        subTitleLabel.text = rate.comment
        starsLabel.text = String(rate.score)
    }
}
