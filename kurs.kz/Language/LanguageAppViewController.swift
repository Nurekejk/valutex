//
//  LanguageAppViewController.swift
//  kurs.kz
//
//  Created by Diar Orynbek on 10.07.2023.
//

import UIKit
import SnapKit

final class LanguageAppViewController: UIViewController {
    
    // MARK: - State
    private var selectedIndexPath: IndexPath = IndexPath(row: 0, section: 0) {
        didSet {
            tableView.reloadData()
        }
    }
    
    private let languages: [String] = ["English", "Русский", "Қазақша"]
    
    // MARK: - UI
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(LanguageTableViewCell.self, forCellReuseIdentifier: LanguageTableViewCell.reuseID)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 56
        return tableView
    }()
    
    private var selectButton: UIButton = {
        let button = UIButton()
        button.setTitle("Выбрать", for: .normal)
        button.layer.cornerRadius = 12
        button.backgroundColor = AppColor.primaryBase.uiColor
        button.addTarget(LanguageAppViewController.self,
                         action: #selector(selectButtonDidPress),
                         for: .touchUpInside)
        return button
    }()
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
    
        loadData()
        setupNavigationBar()
        setupViews()
        setupConstraits()
    }
    
    // MARK: - Setup NavigationBar
    private func setupNavigationBar() {
        title = "Язык приложения"
    }

    private func loadData() {
        let defaults = UserDefaults.standard
        let selectedLanguage = defaults.string(forKey: "LanguageApp")
        
        if selectedLanguage == "EN" {
            selectedIndexPath = IndexPath(row: 0, section: 0)
        } else if selectedLanguage == "RU" {
            selectedIndexPath = IndexPath(row: 1, section: 0)
        } else if selectedLanguage == "KZ" {
            selectedIndexPath = IndexPath(row: 2, section: 0)
        }
    }

    // MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = AppColor.gray10.uiColor
        tableView.backgroundColor = AppColor.gray10.uiColor
        
        [tableView, selectButton].forEach {
            view.addSubview($0)
        }
    }
    
    // MARK: - Setup Constraits
    private func setupConstraits() {
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.bottom.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        selectButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-60)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(52)
        }
    }
    
    // MARK: - Actions
    @objc private func selectButtonDidPress() {
        let defaults = UserDefaults.standard
        if selectedLanguage == Language.kazakh {
            defaults.set("KZ", forKey: "LanguageApp")
        } else if selectedLanguage == Language.russian {
            defaults.set("RU", forKey: "LanguageApp")
        } else if selectedLanguage == Language.english {
            defaults.set("EN", forKey: "LanguageApp")
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension LanguageAppViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LanguageTableViewCell.reuseID,
                                                 for: indexPath) as? LanguageTableViewCell
        let language = languages[indexPath.row]
        
        cell?.confgireCell(language: language, isSelected: selectedIndexPath == indexPath)
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        print(indexPath)
    }
}
