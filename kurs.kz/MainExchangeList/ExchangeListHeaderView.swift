//
//  ExchangeListHeaderView.swift
//  kurs.kz
//
//  Created by MacBook on 18.07.2023.
//
import UIKit
import SnapKit

final class ExchangeListHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - State
    static let identifier = "ExchangeListTableHeader"
    
    public var сompletion: (ButtonState, ButtonState) -> Void = { ( _: ButtonState, _: ButtonState) in }
    
    // MARK: - Properties
    private var buyRateSorterState = ButtonState.isOff
    private var sellRateSorterState = ButtonState.isOff
    
    // MARK: - UI
    private lazy var buyLabel: UILabel = {
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
    private lazy var buyRateFilterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(AppImage.arrow_back.uiImage, for: .normal)
        button.addTarget(self, action: #selector(buyFilterButtonDidPress(sender:)), for: .touchUpInside)
        return button
    }()
    private lazy var sellRateFilterButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(AppImage.arrow_back.uiImage, for: .normal)
        button.addTarget(self, action: #selector(sellFilterButtonDidPress(sender:)), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initializers
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
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
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0,
                                                                    left: 0,
                                                                    bottom: 4,
                                                                    right: 0))
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        [buyLabel, sellLabel,
         buyRateFilterButton, sellRateFilterButton].forEach {contentView.addSubview($0)}
        contentView.backgroundColor = AppColor.grayWhite.uiColor
    }
    
    // MARK: - Action
    @objc func buyFilterButtonDidPress(sender: UIButton) {
        sellRateSorterState = ButtonState.isOff
        sellRateFilterButton.setImage(AppImage.arrow_back.uiImage, for: .normal)
        if buyRateSorterState == .isOff {
            buyRateFilterButton.setImage(AppImage.up_down_filter.uiImage, for: .normal)
            buyRateSorterState = .ascending
        } else if buyRateSorterState == .ascending {
            buyRateFilterButton.setImage(AppImage.down_up_filter.uiImage, for: .normal)
            buyRateSorterState = .descending
        } else {
            buyRateFilterButton.setImage(AppImage.arrow_back.uiImage, for: .normal)
            buyRateSorterState = .isOff
        }
        сompletion(buyRateSorterState, sellRateSorterState)
    }
    
    @objc func sellFilterButtonDidPress(sender: UIButton) {
        buyRateSorterState = ButtonState.isOff
        buyRateFilterButton.setImage(AppImage.arrow_back.uiImage, for: .normal)
        if sellRateSorterState == .isOff {
            sellRateFilterButton.setImage(AppImage.up_down_filter.uiImage, for: .normal)
            sellRateSorterState = .ascending
        } else if sellRateSorterState == .ascending {
            sellRateFilterButton.setImage(AppImage.down_up_filter.uiImage, for: .normal)
            sellRateSorterState = .descending
        } else {
            sellRateFilterButton.setImage(AppImage.arrow_back.uiImage, for: .normal)
            sellRateSorterState = .isOff
        }
        сompletion(buyRateSorterState, sellRateSorterState)
    }
    public func resetSorters() {
        buyRateSorterState = ButtonState.isOff
        sellRateSorterState = ButtonState.isOff
        buyRateFilterButton.setImage(AppImage.arrow_back.uiImage, for: .normal)
        sellRateFilterButton.setImage(AppImage.arrow_back.uiImage, for: .normal)
        сompletion(buyRateSorterState, sellRateSorterState)
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        sellRateFilterButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-12.5)
            make.size.equalTo(12)
        }
        sellLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(sellRateFilterButton.snp.leading).offset(-4)
            make.height.equalTo(12)
        }
        buyRateFilterButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(sellLabel.snp.leading).offset(-16.5)
            make.size.equalTo(12)
        }
        buyLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(buyRateFilterButton.snp.leading).offset(-4)
            make.height.equalTo(12)
        }
    }
}
