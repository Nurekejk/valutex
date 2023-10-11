//
//  ChangeExchangeRateViewController.swift
//  kurs.kz
//
//  Created by Nurbol on 24.07.2023.
//

import UIKit
import PanModal

class ChangeExchangeRateViewController: UIViewController {
    
    // MARK: - Properties
    weak var delegate: ChangeExchangeRateViewControllerDelegate?
    private var offerId: Int?
    
    // MARK: - UI
    private let modalview: UIView = {
        let modalview = UIView()
        modalview.backgroundColor = .white
        modalview.layer.cornerRadius = 8
        return modalview
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Укажите новый курс"
        label.font = AppFont.semibold.s18()
        label.textColor = AppColor.gray100.uiColor
        return label
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "cross"), for: .normal)
        button.addTarget(self, action: #selector (cancelButtonDidPressed), for: .touchUpInside)
        return button
    }()
    
    private let headerStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private lazy var exchangeRateTextField: UITextField = {
        let textField = UITextField()
        textField.keyboardType = .decimalPad
        textField.delegate = self
        textField.placeholder = ""
        return textField
    }()
    
    private lazy var minusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "minus"), for: .normal)
        button.addTarget(self, action: #selector(minusButtonDidPress), for: .touchUpInside)
        button.tintColor = AppColor.gray40.uiColor
        button.backgroundColor = AppColor.gray20.uiColor
        button.titleLabel?.font = AppFont.regular.s16()
        button.layer.cornerRadius = 8
        return button
    }()
    
    private lazy var plusButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.addTarget(self, action: #selector(plusButtonDidPress), for: .touchUpInside)
        button.tintColor = AppColor.grayWhite.uiColor
        button.backgroundColor = AppColor.primaryBase.uiColor
        button.titleLabel?.font = AppFont.regular.s16()
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let changeView: UIView = {
        let modalview = UIView()
        modalview.layer.borderWidth = 1
        modalview.layer.borderColor = AppColor.gray30.cgColor
        modalview.layer.cornerRadius = 8
        return modalview
    }()
    
    private let changeStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .center
        stack.axis = .horizontal
        stack.spacing = 16
        stack.distribution = .equalCentering
        return stack
    }()

    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Отмена", for: .normal)
        button.tintColor = AppColor.gray50.uiColor
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.borderColor = AppColor.gray30.cgColor
        button.layer.cornerRadius = 12
        button.titleLabel?.font = AppFont.regular.s16()
        button.addTarget(self, action: #selector (cancelButtonDidPressed), for: .touchUpInside)
        return button
    }()
    
    private lazy var confirmChangeButton: UIButton = {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector (confirmButtonDidPress), for: .touchUpInside)
        button.setTitle("Изменить", for: .normal)
        button.tintColor = AppColor.grayWhite.uiColor
        button.backgroundColor = AppColor.primaryBase.uiColor
        button.titleLabel?.font = AppFont.regular.s16()
        button.layer.cornerRadius = 12
        return button
    }()

    private let textfield: UITextField = {
        let textfield = UITextField()
        return textfield
    }()

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()

    }
    
    // MARK: - Setup Views

    private func setupViews() {
        headerStack.addArrangedSubview(titleLabel)
        headerStack.addArrangedSubview(closeButton)

        changeStack.addArrangedSubview(minusButton)
        changeStack.addArrangedSubview(exchangeRateTextField)
        changeStack.addArrangedSubview(plusButton)

        changeView.addSubview(changeStack)

        modalview.addSubview(headerStack)
        modalview.addSubview(changeView)
        modalview.addSubview(cancelButton)
        modalview.addSubview(confirmChangeButton)
        view.addSubview(modalview)

    }
    // MARK: - Setup Constraints

    private func setupConstraints() {
        let buttonWidth = (UIScreen.main.bounds.width - 44)/2
        modalview.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(250)
        }
        headerStack.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(56)
        }
        changeView.snp.makeConstraints { make in
            make.top.equalTo(headerStack.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        changeStack.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        minusButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.width.height.equalTo(40)
        }
        plusButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.width.height.equalTo(40)
        }
        exchangeRateTextField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.height.equalTo(40)
        }
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(changeView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.width.equalTo(buttonWidth)
            make.height.equalTo(52)
        }
        confirmChangeButton.snp.makeConstraints { make in
            make.top.equalTo(changeView.snp.bottom).offset(16)
            make.leading.equalTo(cancelButton.snp.trailing).offset(12)
            make.width.equalTo(buttonWidth)
            make.height.equalTo(52)
        }

    }

    // MARK: - Actions
    @objc func cancelButtonDidPressed() {
        self.dismiss(animated: true)
    }
    @objc func confirmButtonDidPress() {
        self.dismiss(animated: true)
        delegate?.saveChanges()
    }
    
    @objc func plusButtonDidPress() {
        guard var exchangeRate = Double(exchangeRateTextField.text ?? "0.0") else {return}
        exchangeRate += 1.0
        exchangeRateTextField.text = String(exchangeRate)
    }
    
    @objc func minusButtonDidPress() {
        guard var exchangeRate = Double(exchangeRateTextField.text ?? "0.0") else {return}
        exchangeRate -= 1.0
        if exchangeRate < 0 {
            exchangeRate = 0
        }
        exchangeRateTextField.text = String(exchangeRate)
    }
    
    public func setExchangeRate(rate: Double) {
        exchangeRateTextField.text = String(rate)
    }
    
    public func getExchangeRate() -> Double {
        Double(exchangeRateTextField.text ?? "0.0") ?? 0.0
    }
    
    public func setOfferId(id: Int) {
        offerId = id
    }
    
    public func getOfferId() -> Int? {
        offerId
    }
}

    // MARK: - TextFieldDelegate
extension ChangeExchangeRateViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
}
    // MARK: - Protocol
protocol ChangeExchangeRateViewControllerDelegate: AnyObject {
    func saveChanges()
}
    
    // MARK: - Panmodal
extension ChangeExchangeRateViewController: PanModalPresentable {
    
    var panScrollable: UIScrollView? {
        return nil
    }
    var dragIndicatorBackgroundColor: UIColor {
        .clear
    }
    
    var shortFormHeight: PanModalHeight {
        return .contentHeightIgnoringSafeArea(250)
    }
//    var longFormHeight: PanModalHeight {
//        return .maxHeight
//    }
}
