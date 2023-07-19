//
//  CalculatorTableViewCell.swift
//  kurs.kz
//
//  Created by Акерке on 19.07.2023.
//

import UIKit

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
        label.font = .boldSystemFont(ofSize: 16)
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
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    private lazy var addressLabel: UILabel = {
        let label = UILabel()
        label.text = "ул. Толе Би, 297 г, уг. ул. Тлендиева"
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    private lazy var kmLabel: UILabel = {
        let label = UILabel()
        label.text = "1 км"
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "1 октября, 2023 18:00:00"
        label.font = .systemFont(ofSize: 14)
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
               make.top.equalToSuperview().offset(8)
               make.leading.equalToSuperview().offset(24)
               make.trailing.equalToSuperview().offset(-24)
               make.bottom.equalToSuperview().offset(-8)
           }

           migLogoImage.snp.makeConstraints { make in
               make.top.equalToSuperview().offset(16)
               make.leading.equalToSuperview().offset(16)
           }

           titleLabel.snp.makeConstraints { make in
               make.top.equalTo(titleLabel.snp.bottom).offset(8)
               make.leading.equalToSuperview().offset(16)
               make.trailing.equalToSuperview().offset(-40)

           }
           starImage.snp.makeConstraints { make in
               make.top.equalTo(subTitleLabel.snp.bottom).offset(8)
               make.trailing.equalToSuperview().offset(-16)
           }
       }
   }
