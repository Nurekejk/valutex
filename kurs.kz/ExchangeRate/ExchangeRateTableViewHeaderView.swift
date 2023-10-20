//
//  ExchangeRateTableViewHeaderView.swift
//  kurs.kz
//
//  Created by Акерке on 18.07.2023.
//

import UIKit

final class ExchangeRateTableViewHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - State
    static let reuseID = String(describing: ExchangeRateTableViewHeaderView.self)
    
    // MARK: - Properties
    public var buttonAction: ((ButtonState, ButtonState) -> Void)?
    private var buyRateSorterState = ButtonState.isOff
    private var sellRateSorterState = ButtonState.isOff
    
    // MARK: - UI
    private lazy var purchaseLabel: UILabel = {
        let label = UILabel()
        label.text = "Покупка"
        label.textColor = AppColor.gray50.uiColor
        label.font = AppFont.regular.s10()
        return label
    }()

    private lazy var sellLabel: UILabel = {
        let label = UILabel()
        label.text = "Продажа"
        label.textColor = AppColor.gray50.uiColor
        label.font = AppFont.regular.s10()
        return label
    }()
    
    private lazy var buyRateSorterButton: ButtonWithBiggerArea = {
        let button = ButtonWithBiggerArea(type: .system)
        button.setImage(AppImage.arrow_back.uiImage, for: .normal)
        button.addTarget(self, action: #selector(buyFilterButtonDidPress(sender:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var sellRateSorterButton: ButtonWithBiggerArea = {
        let button = ButtonWithBiggerArea(type: .system)
        button.setImage(AppImage.arrow_back.uiImage, for: .normal)
        button.addTarget(self, action: #selector(sellFilterButtonDidPress(sender:)), for: .touchUpInside)
        return button
    }()

    // MARK: - LifeCycle
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.layer.masksToBounds = true
        contentView.clipsToBounds = true
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0,
                                                                    left: 0,
                                                                    bottom: 4,
                                                                    right: 0))
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        [purchaseLabel, sellLabel, buyRateSorterButton, sellRateSorterButton].forEach {
            contentView.addSubview($0)
        }
        contentView.backgroundColor = AppColor.grayWhite.uiColor
    }
    // MARK: - Setup Constraints
    func setupConstraints() {
        sellRateSorterButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-5)
            make.size.equalTo(12)
        }
        
        sellLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.trailing.equalTo(sellRateSorterButton.snp.leading).offset(-4)
            make.bottom.equalToSuperview().offset(-12)
        }
        
        buyRateSorterButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(sellLabel.snp.leading).offset(-17.5)
            make.size.equalTo(12)
        }
        
        purchaseLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12)
            make.trailing.equalTo(buyRateSorterButton.snp.leading).offset(-4)
            make.bottom.equalToSuperview().offset(-12)
        }
    }
    
    // MARK: - Actions
    @objc func buyFilterButtonDidPress(sender: UIButton) {
        sellRateSorterState = ButtonState.isOff
        sellRateSorterButton.setImage(AppImage.arrow_back.uiImage, for: .normal)
        if buyRateSorterState == .isOff {
            buyRateSorterButton.setImage(AppImage.up_down_filter.uiImage, for: .normal)
            buyRateSorterState = .ascending
        } else if buyRateSorterState == .ascending {
            buyRateSorterButton.setImage(AppImage.down_up_filter.uiImage, for: .normal)
            buyRateSorterState = .descending
        } else {
            buyRateSorterButton.setImage(AppImage.arrow_back.uiImage, for: .normal)
            buyRateSorterState = .isOff
        }
        buttonAction?(buyRateSorterState, sellRateSorterState)
    }
    
    @objc func sellFilterButtonDidPress(sender: UIButton) {
        buyRateSorterState = ButtonState.isOff
        buyRateSorterButton.setImage(AppImage.arrow_back.uiImage, for: .normal)
        if sellRateSorterState == .isOff {
            sellRateSorterButton.setImage(AppImage.up_down_filter.uiImage, for: .normal)
            sellRateSorterState = .ascending
        } else if sellRateSorterState == .ascending {
            sellRateSorterButton.setImage(AppImage.down_up_filter.uiImage, for: .normal)
            sellRateSorterState = .descending
        } else {
            sellRateSorterButton.setImage(AppImage.arrow_back.uiImage, for: .normal)
            sellRateSorterState = .isOff
        }
        buttonAction?(buyRateSorterState, sellRateSorterState)
    }
}
