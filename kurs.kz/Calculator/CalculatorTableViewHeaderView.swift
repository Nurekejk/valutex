//
//  CalculatorTableViewHeaderView.swift
//  kurs.kz
//
//  Created by Акерке on 19.07.2023.
//

import UIKit
import SnapKit

final class CalculatorTableViewHeaderView: UITableViewHeaderFooterView {

    // MARK: - Public

    //    public static var reuseIdentifier = String(describing: CalculatorTableViewHeaderView.self)

    // MARK: - UI

    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()
    private lazy var flagImage1: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "KZTflag")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private lazy var currencyLabel1: UILabel = {
        let label = UILabel()
        label.text = "KZT"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    private lazy var dropDownButton1: UIButton = {
        let button = UIButton(type: .system)
        let iconImage = UIImage(named: "drop-down")
        button.setImage(iconImage, for: .normal)
        button.addTarget(self, action: #selector(dropDownButtonDidPressed),
                         for: .touchUpInside)
        return button
    }()
    private lazy var separatorLineImage1: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "separator-line")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private lazy var arrowLeftRightButton: UIButton = {
        let button = UIButton(type: .system)
        let iconImage = UIImage(named: "arrow-left-right")
        button.setImage(iconImage, for: .normal)
        button.addTarget(self, action: #selector(arrowLeftRightButtonDidPressed),
                         for: .touchUpInside)
        return button
    }()
    private lazy var separatorLineImage2: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "separator-line")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private lazy var flagImage2: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "KZTflag")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private lazy var currencyLabel2: UILabel = {
        let label = UILabel()
        label.text = "KZT"
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    private lazy var dropDownButton2: UIButton = {
        let button = UIButton(type: .system)
        let iconImage = UIImage(named: "drop-down")
        button.setImage(iconImage, for: .normal)
        button.addTarget(self, action: #selector(dropDownButtonDidPressed),
                         for: .touchUpInside)
        return button
    }()
    private lazy var currencyTextField: UITextField = {
        let textField = UITextField()
        textField.rightViewMode = .always
        textField.font = .systemFont(ofSize: 16)
        textField.text = "500.00"
        return textField
    }()
    private lazy var clearButton: UIButton = {
        let button = UIButton(type: .system)
        let iconImage = UIImage(named: "icon-clear")
        button.setImage(iconImage, for: .normal)
        button.addTarget(self, action: #selector(clearButtonDidPressed),
                         for: .touchUpInside)
        return button
    }()
    private lazy var borderView: UIView = {
        let view = UIView()
        return view
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
        containerView.layer.cornerRadius = 8
    }
    // MARK: - Setup Views

    private func setupViews() {
        [flagImage1, currencyLabel1, dropDownButton1, separatorLineImage1,
         arrowLeftRightButton, flagImage2, currencyLabel2, dropDownButton2,
         separatorLineImage2, currencyTextField, clearButton, borderView].forEach {
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
        containerView.addSubview(borderView)
        borderView.backgroundColor = backgroundGrayColor
    }
    // MARK: - Setup Constraints
    
    func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-24)
            make.bottom.equalToSuperview().offset(-4) }
        borderView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalToSuperview().offset(46)
            make.leading.equalTo(containerView.snp.leading)
            make.trailing.equalTo(containerView.snp.trailing) }
        flagImage1.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16) }
        currencyLabel1.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14)
            make.leading.equalTo(flagImage1.snp.trailing).offset(16) }
        dropDownButton1.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalTo(currencyLabel1.snp.trailing).offset(16) }
        separatorLineImage1.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalTo(dropDownButton1.snp.trailing).offset(33.5) }
        arrowLeftRightButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalTo(separatorLineImage1.snp.trailing).offset(12)
        }
        separatorLineImage2.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalTo(arrowLeftRightButton.snp.trailing).offset(12)
        }
        dropDownButton2.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-18.5)
        }
        currencyLabel2.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(14)
            make.trailing.equalTo(dropDownButton2.snp.leading).offset(-16)
        }
        flagImage2.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.trailing.equalTo(currencyLabel2.snp.leading).offset(-16)
        }
        currencyTextField.snp.makeConstraints { make in
            make.top.equalTo(flagImage1.snp.bottom).offset(27)
            make.leading.equalToSuperview().offset(16)
        }
        clearButton.snp.makeConstraints { make in
            make.top.equalTo(flagImage1.snp.bottom).offset(27)
            make.trailing.equalToSuperview().offset(-16)
        }
    }

    // MARK: - Actions

    @objc private func dropDownButtonDidPressed() {

    }
    @objc private func arrowLeftRightButtonDidPressed() {

    }
    @objc private func clearButtonDidPressed() {

    }
}
