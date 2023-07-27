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
        label.font = AppFont.regular.s14()
        return label
    }()
    
    private lazy var vtLabel: UILabel = {
        let label = UILabel()
        label.text = "Вт"
        label.font = AppFont.regular.s14()
        return label
    }()
    
    private lazy var srLabel: UILabel = {
        let label = UILabel()
        label.text = "Ср"
        label.font = AppFont.regular.s14()
        return label
    }()
    
    private lazy var chLabel: UILabel = {
        let label = UILabel()
        label.text = "Чт"
        label.font = AppFont.regular.s14()
        return label
    }()
    
    private lazy var ptLabel: UILabel = {
        let label = UILabel()
        label.text = "Пт"
        label.font = AppFont.regular.s14()
        return label
    }()
    
    private lazy var sbLabel: UILabel = {
        let label = UILabel()
        label.text = "Сб"
        label.font = AppFont.regular.s14()
        return label
    }()
    
    private lazy var vsLabel: UILabel = {
        let label = UILabel()
        label.text = "Вс"
        label.font = AppFont.regular.s14()
        return label
    }()
    
    private lazy var monday: UILabel = {
        let label = UILabel()
        label.text = " 09:00 - 21:00"
        label.font = AppFont.bold.s14()
        return label
    }()
    
    private lazy var saturday: UILabel = {
        let label = UILabel()
        label.text = " Выходной"
        label.font = AppFont.bold.s16()
        return label
    }()
    
    private lazy var secondsaturday: UILabel = {
        let label = UILabel()
        label.text = " Выходной"
        label.font = AppFont.bold.s16()
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
        
        [pnLabel, vtLabel, srLabel, chLabel, ptLabel, sbLabel, vsLabel].forEach {
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
        
        vtLabel.snp.makeConstraints { make in
            make.top.equalTo(pnLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(18)
        }
        
        srLabel.snp.makeConstraints { make in
            make.top.equalTo(vtLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(18)
        }
        
        chLabel.snp.makeConstraints { make in
            make.top.equalTo(srLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(18)
        }
        
        sbLabel.snp.makeConstraints { make in
            make.top.equalTo(chLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(18)
        }
        
        vsLabel.snp.makeConstraints { make in
            make.top.equalTo(sbLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(18)
        }
    }
}
