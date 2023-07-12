//
//  languageAppViewController.swift
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
    
    private let languages: [String] = ["Русский", "Казакша", "English"]
    
    // MARK: - UI
    
    private var label: UILabel = {
        let label = UILabel()
        label.text = "Язык приложения"
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        
        return label
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(LanguageTableViewCell.self, forCellReuseIdentifier: "lamguages_cell")
        tableView.rowHeight = 56
        
        return tableView
    }()
    
    private var selectButton: UIButton = {
        let button = UIButton()
        button.setTitle("Выбрать", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 12
        
        return button
    }()
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraits()
    }
    
    // MARK: - Setup Views
    
    func setupViews() {
        view.backgroundColor = .white
        view.addSubview(label)
        view.addSubview(tableView)
        view.addSubview(selectButton)
    }
    
    // MARK: - Setup Constraits
    
    func setupConstraits() {
        
        label.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(115)
            make.trailing.equalToSuperview().offset(-115)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(label.snp.bottom).offset(72)
            make.bottom.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
        }
        
        selectButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(628)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(52)
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension LanguageAppViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lamguages_cell",
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
