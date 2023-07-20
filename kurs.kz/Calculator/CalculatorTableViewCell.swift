//
//  CalculatorTableViewCell.swift
//  kurs.kz
//
//  Created by Акерке on 19.07.2023.
//

import UIKit
import SnapKit

final class CalculatorTableViewCell: UITableViewCell {

    // MARK: - Public

    public static var reuseIdentifier = String(describing: CalculatorTableViewCell.self)

    // MARK: - UI

    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    private lazy var migLogoImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "migLogo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "MИГ"
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    private lazy var starImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "star")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private lazy var rateLabel: UILabel = {
        let label = UILabel()
        label.text = "4,9 (15)"
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor.lightGray
        return label
    }()
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.text = "ул. Толе Би, 297 г, уг. ул. Тлендиева"
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    private lazy var kmLabel: UILabel = {
        let label = UILabel()
        label.text = "1 км"
        label.font = .systemFont(ofSize: 10)
        return label
    }()
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "1 октября, 2023 18:00:00"
        label.font = .systemFont(ofSize: 12)
        label.textColor = UIColor.lightGray
        label.textAlignment = .left
        return label
    }()
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        label.text = "1000,01"
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
        setupConstraints()

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        containerView.layer.cornerRadius = 8
    }

    // MARK: - Setup Views

    private func setupViews() {
        [migLogoImage, titleLabel, starImage, rateLabel,
         addressLabel, kmLabel, dateLabel,amountLabel].forEach {
            containerView.addSubview($0)
        }
        let backgroundGrayColor = UIColor(
            red: 246.0 / 255.0,
            green: 247.0 / 255.0,
            blue: 249.0 / 255.0,
            alpha: 1)

        contentView.backgroundColor = backgroundGrayColor
        containerView.backgroundColor = .white
        contentView.addSubview(containerView)
    }

    // MARK: - Setup Constraints

    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.bottom.equalToSuperview().offset(-4)
        }
        migLogoImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(17.5)
            make.leading.equalToSuperview().offset(12)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.leading.equalTo(migLogoImage.snp.trailing).offset(16)
        }
        starImage.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.leading.equalTo(titleLabel.snp.trailing).offset(8)
        }
        rateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(13.5)
            make.leading.equalTo(starImage.snp.trailing).offset(4)
        }
        addressLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.leading.equalTo(migLogoImage.snp.trailing).offset(16)
        }
        kmLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(33.5)
            make.trailing.equalToSuperview().offset(-44)
        }
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(kmLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(12)
        }
        amountLabel.snp.makeConstraints { make in
            make.top.equalTo(kmLabel.snp.bottom).offset(8)
            make.trailing.equalToSuperview().offset(-12)
        }
    }
    // MARK: - Public

       public func configureCell(migLogoImage: UIImage?,
                                 titleLabel: String,
                                 starImage: UIImage?,
                                 rateLabel: String,
                                 addressLabel: String,
                                 kmLabel: String,
                                 dateLabel: String,
                                 amountLabel: String) {
           if let flagImage = migLogoImage {
               self.migLogoImage.image = migLogoImage
           }
           self.titleLabel.text = titleLabel
           if let starImage = starImage {
               self.starImage.image = starImage
           }
           self.rateLabel.text = rateLabel
           self.addressLabel.text = rateLabel
           self.kmLabel.text = rateLabel
           self.dateLabel.text = rateLabel
           self.amountLabel.text = rateLabel
       }
}
