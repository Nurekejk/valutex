//
//  ExchangeRateAddCurrencyViewController.swift
//  kurs.kz
//
//  Created by MacBook on 16.10.2023.
//

import SnapKit
import UIKit
import SkyFloatingLabelTextField

final class AddCurrencyViewController: UIViewController {
    
    // MARK: - Properties
    private let factory = SkyFloatingLabelTextfieldFactory()
    private var existingCurrencies: [CurrencyElementForExchangeRateVC] = []
    private var selectedCurrency = Currency(flag: "🇺🇸",
                                            russianName: "доллар",
                                            symbol: "$",
                                            code: "USD",
                                            kazakhName: "доллар",
                                            englishName: "dollar")
    weak var delegate: AddCurrencyViewControllerDelegate?
    
    // MARK: - UI
    private lazy var currencyTextField: SkyFloatingLabelTextField = {
        let textField = factory.getTextfield(with: "Валюта")
        textField.text = "🇺🇸 доллар"
        textField.isUserInteractionEnabled = false
        return textField
    }()
    
    private lazy var buyRateTextfield: SkyFloatingLabelTextField = {
        let textField = factory.getTextfield(with: "Покупка")
        textField.keyboardType = .decimalPad
        textField.delegate = self
        return textField
    }()
    
    private lazy var sellRateTextfield: SkyFloatingLabelTextField = {
        let textField = factory.getTextfield(with: "Продажа")
        textField.keyboardType = .decimalPad
        textField.delegate = self
        return textField
    }()
    private lazy var dropDownButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(AppImage.down_arrow.uiImage, for: .normal)
        button.addTarget(self, action: #selector(downButtonDidPress), for: .touchUpInside)
        return button
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 16,
                                                                     leading: 0,
                                                                     bottom: 16,
                                                                     trailing: 0)
        stackView.spacing = 16
        return stackView
    }()
    
    private let saveButtonContainerView: UIView = {
        let container = UIView()
        container.backgroundColor = AppColor.grayWhite.uiColor
        return container
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Сохранить", for: .normal)
        button.titleLabel?.font = AppFont.semibold.s16()
        button.setTitleColor(AppColor.grayWhite.uiColor, for: .normal)
        button.backgroundColor = AppColor.primaryBase.uiColor
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(saveButtonDidPress), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initializers
    init(existingCurrencies: [CurrencyElementForExchangeRateVC]) {
        self.existingCurrencies = existingCurrencies
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
        setupNavigationBar()
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        stackView.backgroundColor = .white
        stackView.layer.cornerRadius = 8
        view.backgroundColor = .systemGray6
        
        [currencyTextField, buyRateTextfield, sellRateTextfield].forEach { stackView.addArrangedSubview($0) }
        saveButtonContainerView.addSubview(saveButton)
        
        [stackView, saveButtonContainerView, dropDownButton].forEach {
            view.addSubview($0)
        }
    }
    
    // MARK: - Navigation Bar
    private func setupNavigationBar() {
        title = "Курс валют"
    }
    
    // MARK: - Action
    @objc func downButtonDidPress() {
        let modalScreen = CurrencySelectorViewController()
        modalScreen.delegate = self
        self.presentPanModal(modalScreen)
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "Ошибка!",
                                      message: "Валюта, которую вы собираетесь добавить уже существует.",
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func saveButtonDidPress() {
        if existingCurrencies.contains(where: { currency in
            print(currency.currencyCode)
            print(selectedCurrency.code)
            return currency.currencyCode == selectedCurrency.code
        }) {
            showAlert()
        } else {
            let buyRate = Double(buyRateTextfield.text ?? "0.0")
            let sellRate = Double(buyRateTextfield.text ?? "0.0")
            let newCurrency = CurrencyElementForExchangeRateVC(currencyRateId: nil,
                                                               currencyCode: selectedCurrency.code,
                                                               currencyFlag: selectedCurrency.flag,
                                                               currencyKzName: selectedCurrency.kazakhName,
                                                               currencyRuName: selectedCurrency.russianName,
                                                               currencyEngName: selectedCurrency.englishName,
                                                               buyPrice: buyRate,
                                                               sellPrice: sellRate)
     
            delegate?.currencyDidAdd(currency: newCurrency)
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        saveButton.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(52)
        }
        
        saveButtonContainerView.snp.makeConstraints { make in
            make.bottom.leading.trailing.equalToSuperview()
            make.height.equalTo(112)
        }

        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.height.equalTo(274)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        dropDownButton.snp.makeConstraints { make in
            make.centerY.equalTo(currencyTextField)
            make.size.equalTo(15)
            make.trailing.equalTo(currencyTextField.snp.trailing).offset(-22)
        }
        
        [currencyTextField, buyRateTextfield, sellRateTextfield].forEach({$0.snp.makeConstraints { make in
            make.leading.equalTo(stackView.snp.leading).offset(16)
            make.trailing.equalTo(stackView.snp.trailing).offset(-16)
        }})
    }
}

    // MARK: - CurrencySelectorViewControllerDelegate
extension AddCurrencyViewController: CurrencySelectorViewControllerDelegate {
    func currencyDidSelect(currency: Currency) {
        selectedCurrency = currency
        currencyTextField.text = "\(currency.flag) \(currency.russianName)"
    }
}

    // MARK: - TextFieldDelegate
extension AddCurrencyViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
}

protocol AddCurrencyViewControllerDelegate: AnyObject {
    func currencyDidAdd(currency: CurrencyElementForExchangeRateVC)
}
