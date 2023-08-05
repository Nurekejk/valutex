//
//  SectionHeader.swift
//  kurs.kz
//
//  Created by Nurbol on 23.07.2023.
//

import UIKit

class SectionHeader: UITableViewHeaderFooterView {

    let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        return label
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupHierarchy() {
        contentView.addSubview(label)
    }

    private func setupLayout() {

        label.snp.makeConstraints { make in
            make.centerY.equalTo(contentView)
            make.top.equalToSuperview().offset(10)
        }
    }
}
