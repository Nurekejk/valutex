//
//  PartnerOfferAcceptedTableViewCell.swift
//  kurs.kz
//
//  Created by MacBook on 10.10.2023.
//

import UIKit

final class PartnerOfferAcceptedTableViewCell: UITableViewCell {
    
    // MARK: - State
    static let reuseID = String(describing: PartnerOfferAcceptedTableViewCell.self)
    
    // MARK: - Properties
    private var timeRemaining: Int = 1800
    private var timer: Timer?
    private var type: PartnerOfferType?
    
    var cancelButtonAction : (() -> Void)?
    
    private var offerRequest: AcceptedSentOfferResponse? {
        didSet {
            print("here in setupcell")
            guard let nonNilOffer = offerRequest else {
                print("offer request set to nil")
                return
            }
            
            if let score = nonNilOffer.score, let scoreCount = nonNilOffer.scoreCount {
                ratingLabel.text = "\(score) (\(scoreCount))"
                print("scorecout is \(scoreCount)")
            } else {
                ratingLabel.text = "no scores"
            }
            if let name = nonNilOffer.userName, let surname = nonNilOffer.userSurname {
                partnerNameLabel.text = name + " " + surname
            }
            if let userPhone = nonNilOffer.userPhone {
                phoneNumberLabel.text = format(with: "+X (XXX) XXX-XX-XX", phone: userPhone)
            }
            buyingLabel.text = nonNilOffer.offerType == "BUY" ? "Покупает:" : "Продает:"
            if let exchangeAmount = nonNilOffer.exchangeAmount {
                buyingSumLabel.text = String(exchangeAmount) + " ₸"
            }
            if let exchangeRate = nonNilOffer.exchangeRate,
               let currencySymbol = nonNilOffer.exchangeCurrencySymbol {
                currencySumLabel.text = String(exchangeRate) + " " + String(currencySymbol)
            }
            print("nonNilOffer.exchangeCurrency \(nonNilOffer.exchangeCurrency)")
        }
    }
    
    // MARK: - UI
    private lazy var partnerNameLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        label.textColor = UIColor(named: "partnerOfferBasicTextColor")
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var starImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = AppImage.star12.uiImage
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = UIColor(named: "partnerOfferGrayTextColor")
        label.font = AppFont.regular.s12()
        return label
    }()
    
    private lazy var partnerNameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = AppColor.gray100.uiColor
        label.font = AppFont.regular.s12()
        return label
    }()
    
    private lazy var buyingLabel: UILabel = {
        let label = UILabel()
        label.text = " "
        label.textColor = UIColor(named: "partnerOfferGrayTextColor")
        label.font = AppFont.regular.s12()
        return label
    }()
    
    private lazy var buyingSumLabel: UILabel = {
        let label = UILabel()
        label.text = "250 500 ₸  "
        label.textColor = UIColor(named: "partnerOfferBasicTextColor")
        label.font = AppFont.regular.s12()
        return label
    }()
    
    private lazy var currencyLabel: UILabel = {
        let label = UILabel()
        label.text = "по курсу: "
        label.textColor = UIColor(named: "partnerOfferGrayTextColor")
        label.font = AppFont.regular.s12()
        return label
    }()
    
    private lazy var currencySumLabel: UILabel = {
        let label = UILabel()
        label.text = "500$"
        label.textColor = UIColor(named: "partnerOfferBasicTextColor")
        label.font = AppFont.regular.s12()
        return label
    }()
    
    private lazy var currencyInformationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.spacing = 2
        return stackView
    }()
    
    private let timerLabel: UILabel = {
        let label = UILabel()
        label.textColor = AppColor.primaryBase.uiColor
        label.font = AppFont.semibold.s16()
        return label
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(named: "cancelButtonColor")
        button.setTitle("Отменить", for: .normal)
        button.setTitleColor(UIColor(named: "cancelButtonTitleColor"), for: .normal)
        button.titleLabel?.font = AppFont.regular.s14()
        button.addTarget(self, action: #selector(cancelButtonDidPressed), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.cornerRadius = 8
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0))
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        [buyingLabel, buyingSumLabel, currencyLabel, currencySumLabel].forEach {
            currencyInformationStackView.addArrangedSubview($0)
        }
        
        [partnerNameLabel, starImageView, ratingLabel].forEach {
            partnerNameStackView.addArrangedSubview($0)
        }
        
        contentView.backgroundColor = AppColor.grayWhite.uiColor
        [partnerNameStackView,
         phoneNumberLabel,
         currencyInformationStackView].forEach {
            contentView.addSubview($0)
        }
        
        if type == .accepted {
            contentView.addSubview(timerLabel)
        } else {
            contentView.addSubview(cancelButton)
        }
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        partnerNameStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.height.equalTo(18)
        }
        
        phoneNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(partnerNameLabel.snp.bottom).offset(4)
            make.leading.equalToSuperview().offset(16)
        }
        
        currencyInformationStackView.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        
        if type == .accepted {
            timerLabel.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(16)
                make.trailing.equalToSuperview().offset(-16)
            }
        } else {
            cancelButton.snp.makeConstraints { make in
                make.top.equalTo(currencyInformationStackView.snp.bottom).offset(16)
                make.leading.equalToSuperview().offset(16)
                make.trailing.equalToSuperview().offset(-16)
                make.height.equalTo(42)
            }
        }
    }
    
    // MARK: - Actions
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1,
                                     target: self,
                                     selector: #selector(updateTime),
                                     userInfo: nil,
                                     repeats: true)
    }
    
    private func timeFormatter(_ seconds: Int) -> String {
        let minutes = Int(timeRemaining)/60 % 60
        let seconds = Int(timeRemaining) % 60
        let timeString = String(format: "%02d:%02d", minutes, seconds)
        return timeString
    }
    
    @objc private func updateTime() {
        if timeRemaining >= 0 {
            timerLabel.text = "\(timeFormatter(timeRemaining))"
            timeRemaining -= 1
        } else {
            timer?.invalidate()
        }
    }
    
    @objc private func cancelButtonDidPressed() {
        cancelButtonAction?()
    }
    
    private func format(with mask: String, phone: String) -> String {
        let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        var result = ""
        var index = numbers.startIndex
        
        for ch in mask where index < numbers.endIndex {
            if ch == "X" {
                result.append(numbers[index])
                
                // move numbers iterator to the next index
                index = numbers.index(after: index)
                
            } else {
                result.append(ch) // just append a mask character
            }
        }
        return result
    }
    
    public func configureCell(with offer: AcceptedSentOfferResponse, type: PartnerOfferType) {
        print(type)
        offerRequest = offer
        self.type = type
        if type == .accepted {
            startTimer()
        }
        setupViews()
        setupConstraints()
    }
}
