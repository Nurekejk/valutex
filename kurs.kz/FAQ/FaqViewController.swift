//
//  FaqViewController.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 01.08.2023.
//

import UIKit
import SnapKit
import CollapsibleTableSectionViewController

final class FaqViewController: UIViewController {

    // MARK: - UI
    private let questionSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.setImage(AppImage.search_normal.uiImage, for: .search, state: .normal)
        searchBar.searchTextField.font = AppFont.regular.s14()
        searchBar.searchTextPositionAdjustment.horizontal = CGFloat(12)
        searchBar.searchTextField.backgroundColor = AppColor.grayWhite.uiColor
        searchBar.placeholder = "Что ищете?"
        searchBar.searchBarStyle = .default
        searchBar.barStyle = .default
        searchBar.backgroundColor = AppColor.grayWhite.uiColor
        searchBar.barTintColor = AppColor.grayWhite.uiColor
        
        return searchBar
    }()
    
    private lazy var questionsTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Setup Navigation Bar
    private func setupNavigationBar() {
        self.view.backgroundColor = AppColor.gray10.uiColor
        self.title = "FAQ"
        edgesForExtendedLayout = []
        self.navigationItem.leftBarButtonItem =
        UIBarButtonItem(image: AppImage.arrow_back.uiImage,
                        style: .plain,
                        target: self,
                        action: #selector(backButtonDidPressed))
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        [questionSearchBar, questionsTableView].forEach {
            view.addSubview($0)
        }
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        questionSearchBar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.height.equalTo(48)
        }
        
        questionsTableView.snp.makeConstraints { make in
            make.top.equalTo(questionSearchBar.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
    // MARK: - Actions
    @objc private func backButtonDidPressed() {
        self.navigationController?.popViewController(animated: true)
    }
}
