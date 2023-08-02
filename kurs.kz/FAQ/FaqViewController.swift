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
    
    let service: FaqPageService
    
    var questions: [Question] = []
    
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
        tableView.register(FaqTableHeaderView.self,
                           forHeaderFooterViewReuseIdentifier: FaqTableHeaderView.reuseID)
        tableView.register(FaqTableViewCell.self,
                           forCellReuseIdentifier: FaqTableViewCell.reuseID)
        tableView.separatorStyle = .singleLine
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = AppColor.gray10.uiColor
        return tableView
    }()
    
    // MARK: - Initializers
    init(service: FaqPageService) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupViews()
        setupConstraints()
        fetchQuestionAnswerPairs()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        questionsTableView.layer.cornerRadius = 8.0
        questionSearchBar.layer.cornerRadius = 8.0
    }
    
    // MARK: - Callback
    private func fetchQuestionAnswerPairs() {
        service.fetchFaq { [weak self] result in
            switch result {
            case .success(let data):
                let faqs = data.faq
                faqs.forEach { faq in
                    self?.questions.append(Question(question: faq.question, answer: faq.answer))
                }
                self?.questionsTableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
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
        questionsTableView.estimatedRowHeight = 100
        questionsTableView.rowHeight = UITableView.automaticDimension
        if #available(iOS 15.0, *) {
            questionsTableView.sectionHeaderTopPadding = 2.0
        }
        questionsTableView.sectionHeaderHeight = 50.0
        
        questionSearchBar.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.height.equalTo(48)
        }
        
        questionsTableView.snp.makeConstraints { make in
            make.top.equalTo(questionSearchBar.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Actions
    @objc private func backButtonDidPressed() {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension FaqViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions[section].collapsed ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FaqTableViewCell.reuseID,
                                                       for: indexPath) as? FaqTableViewCell
        else {
            fatalError("Could not cast to FaqTableViewCell")
        }
        cell.faqSection = questions[indexPath.section]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier:
                                                                    FaqTableHeaderView.reuseID)
                as? FaqTableHeaderView
        else {
            fatalError("Could not cast to FaqQuestionTableHeaderView")
        }
        view.section = section
        view.delegate = self
        view.faqSection = questions[section]
        view.backgroundConfiguration?.backgroundColor = .white
        view.setCollapsed(questions[section].collapsed)
        return view
    }
}

extension FaqViewController: FaqTableHeaderViewDelegate {
    func toggleSection(_ header: FaqTableHeaderView, section: Int) {
        let collapsed = !questions[section].collapsed
        questions[section].collapsed = collapsed
        questionsTableView.reloadData()
    }
}
