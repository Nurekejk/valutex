//
//  SelectCityViewController.swift
//  kurs.kz
//
//  Created by Nurbol on 04.07.2023.
//

import UIKit
import SnapKit
import Alamofire

final class SelectCityViewController: UIViewController {
    // MARK: - State
    let userDefaults = UserDefaults.standard
    private var cities: [City] = [] {
      didSet {
          self.tableview.reloadData()
      }
    }
    // MARK: - Outlets
    private let textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.placeholder = "Поиск"
        textField.font = AppFont.regular.s14()
        textField.layer.cornerRadius = 8
        return textField
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = AppImage.search_city.uiImage
        return imageView
    }()

    private lazy var tableview: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(CityTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = 8
        return tableView
    }()

    private lazy var  saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Выбрать", for: .normal)
        button.tintColor = .white
        button.backgroundColor = AppColor.primaryBase.uiColor
        button.layer.cornerRadius = 12
        button.titleLabel?.font = AppFont.semibold.s16()
        button.addTarget(self, action: #selector(saveButtonDidPressed), for: .touchUpInside)
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
        setupNavigationBar()
        setupViews()
        setupConctraints()

        fetchCities()
    }
    
    // MARK: - Setup NavigationBar
    private func setupNavigationBar() {
        title = "Город"
    }

    // MARK: - Setup
    private func setupViews() {
        view.backgroundColor = AppColor.gray10.uiColor
        view.addSubview(textField)
        view.addSubview(tableview)
        view.addSubview(shadowview)

        shadowview.addSubview(saveButton)
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
        saveButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(52)
        }
    }

    // MARK: - Network

    private func fetchCities() {

        var urlComponent = URLComponents()
        urlComponent.scheme = "http"
        urlComponent.host = "77.240.38.143"
        urlComponent.port = 4443
        urlComponent.path = "/cities_list"

        guard let url = urlComponent.url else {
            return
        }

        AF.request(url)
            .validate()
            .responseDecodable(of: [City].self) { data in
                switch data.result {
                case .success(let fetchedCities):
                    self.cities = fetchedCities
                case .failure(let error):
                    print(error)
                }
            }

    }
    // MARK: - Action

    @objc private func saveButtonDidPressed() {
        self.navigationController?.popViewController(animated: true)
    }

}

    // MARK: - UITableViewDataSource, UITableViewDelegate
extension SelectCityViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell",
                                                         for: indexPath) as? CityTableViewCell
        let city = cities[indexPath.row]
        print("Asdasdasd")
        if let data = userDefaults.data(forKey: "selectedCity") {
            print("data2: \(data)")
            do {
                let fetchedCity = try JSONDecoder().decode(City.self, from: data)
                print("fetchedCity: \(fetchedCity)")
                cell?.isSelected = fetchedCity.name_rus == city.name_rus
            } catch {
                print("error while decoding")
            }
            
        }
        cell?.configureCell(name: city.name_rus)
        return cell ?? UITableViewCell()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCity = cities[indexPath.row]
        print("sadsadads")
        if let data = try? JSONEncoder().encode(selectedCity) {
            print(data)
            userDefaults.setValue(data, forKey: "selectedCity")

        } else {
            print("error while encoding")

        }

    }

}
