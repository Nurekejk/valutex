//
//  SelectCityViewController.swift
//  kurs.kz
//
//  Created by Nurbol on 04.07.2023.
//

import UIKit

final class SelectCityViewController: UIViewController {

    // MARK: - Outlets

    private let textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.placeholder = "Поиск"
        textField.font = .systemFont(ofSize: 14)
        textField.layer.cornerRadius = 8
        return textField
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "searchCity")
        return imageView
    }()

    private lazy var tableview: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(CityTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 8
        return tableView
    }()

    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Выбрать", for: .normal)
        button.tintColor = .white
        button.backgroundColor = AppColor.primaryBlue.uiColor
        button.layer.cornerRadius = 12
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        return button
    }()

    private let shadowview: UIView = {
        let shadowview = UIView()
        shadowview.backgroundColor = .white
        return shadowview
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConctraints()
    }

    // MARK: - Setup

    private func setupViews() {
        view.backgroundColor = .systemGray6
        view.addSubview(textField)
        view.addSubview(tableview)
        view.addSubview(shadowview)

        shadowview.addSubview(button)
        textField.addSubview(imageView)
        imageView.frame = CGRect(x: 0, y: 0, width: 20, height: 20)

        textField.leftView = imageView
        textField.leftViewMode = .always

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.widthAnchor.constraint(equalToConstant: 48).isActive = true
        imageView.heightAnchor.constraint(equalTo: textField.heightAnchor).isActive = true
    }

    private func setupConctraints() {
        textField.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(116)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(52)
        }
        tableview.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(1)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview().offset(-118)
        }
        shadowview.snp.makeConstraints { make in
            make.top.equalTo(tableview.snp.bottom)
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(112)
        }
        button.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(52)
        }
    }
}

    // MARK: - UITableViewDataSource, UITableViewDelegate

extension SelectCityViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        15
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let selectedView = UIView()
        selectedView.backgroundColor = UIColor.white
        cell.selectedBackgroundView = selectedView
        return cell
    }
}
