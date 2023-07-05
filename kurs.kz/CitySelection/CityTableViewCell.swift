//
//  CityTableViewCell.swift
//  kurs.kz
//
//  Created by Nurbol on 04.07.2023.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    // MARK: - Outlets
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Алматы"
        return label
    }()

    private let selectImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "selectCity")
        return imageView
    }()

    private let stack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .leading
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.spacing = 1
        return stack
    }()
    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupHierarchy ()
        setupLayout ()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup
    private func setupHierarchy(){
        stack.addArrangedSubview(label)
        stack.addArrangedSubview(selectImageView)
        addSubview(stack)
    }

    private func setupLayout () {
        stack.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().offset(-16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
    }

    // MARK: - Reuse

}
