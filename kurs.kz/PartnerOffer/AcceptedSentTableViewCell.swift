//
//  AcceptedSendTableViewCell.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 16.07.2023.
//

import UIKit
import SnapKit

final class AcceptedSentTableViewCell: UITableViewCell {
    
    // MARK: - State
    var type: PartnerOfferCellType = .accepted
    static let reuseID = String(describing: AcceptedSentTableViewCell.self)
    
    // MARK: - UI
    private lazy var acceptedSendImageView: UIImageView = {
        let imageView = UIImageView()
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
        label.text = "Принятые"
        label.textColor = UIColor(named: "partnerOfferBasicTextColor")
        label.font = AppFont.regular.s16()
        return label
    }()
    
    private lazy var arrowRightImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.arrow_right.uiImage
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
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = 8
        contentView.backgroundColor = AppColor.grayWhite.uiColor
        contentView.layer.masksToBounds = true
        contentView.clipsToBounds = true
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
    
    // MARK: - Public
    public func configureCell(acceptedSendImage: String, acceptedSendText: String) {
        acceptedSendImageView.image = UIImage(named: acceptedSendImage)
        acceptedSendLabel.text = acceptedSendText
    }
}
    // MARK: - Extension: AcceptedSentTableCellProtocol
extension AcceptedSentTableViewCell: AcceptedSentTableCellProtocol {
    func setupCell(with count: Int, type: PartnerOfferCellType) {
        
        if type == .accepted {
            acceptedSendImageView.image = AppImage.acceptedImage.uiImage
            acceptedSendLabel.text = "Принятые (\(count))"
        } else {
            acceptedSendImageView.image = AppImage.sentImage.uiImage
            acceptedSendLabel.text = "Отправленные (\(count))"
        }
    }
}
