//
//  ClockTimeCell.swift
//  kurs.kz
//
//  Created by Diar Orynbek on 23.07.2023.
//

import UIKit
import SnapKit

final class ClockTimeCell: UITableViewCell {
    
    // MARK: - Public
    static let reuseID = String(describing: ClockTimeCell.self)
    
    // MARK: - UI
    private lazy var pnLabel: UILabel = {
        let label = UILabel()
        label.text = "Пн"
        label.font = .systemFont(ofSize: 14)
        return label
    }()

    private lazy var vtLabel: UILabel = {
        let label = UILabel()
        label.text = "Вт"
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var vsLabel: UILabel = {
        let label = UILabel()
        label.text = "Вс"
        label.font = .systemFont(ofSize: 14)
        return label
    }()
    
    private lazy var monday: UILabel = {
        let label = UILabel()
        label.text = " 09:00 - 21:00"
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    
    private lazy var saturday: UILabel = {
        let label = UILabel()
        label.text = " Выходной"
        label.font = .boldSystemFont(ofSize: 16)
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
        [pnLabel, vtLabel, vsLabel, monday, saturday].forEach {
            contentView.addSubview($0)
        }
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        pnLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(18)
        }
        
        monday.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(50)
            make.height.equalTo(18)
        }
        
        vtLabel.snp.makeConstraints { make in
            make.top.equalTo(pnLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(18)
        }
        
        vsLabel.snp.makeConstraints { make in
            make.top.equalTo(monday.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(18)
        }
        
        saturday.snp.makeConstraints { make in
            make.top.equalTo(monday.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(50)
            make.height.equalTo(18)
        }
    }
}
