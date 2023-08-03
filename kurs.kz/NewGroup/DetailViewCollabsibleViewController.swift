//
//  CollapsibleTableViewController.swift
//  kurs.kz
//
//  Created by Diar Orynbek on 03.08.2023.
//

import UIKit
import SnapKit
import CollapsibleTableSectionViewController

// MARK: - View Controller
class DetailViewCollabsibleViewController: UIViewController {
 
    var sections = sectionsData
    
    // MARK: - UI
    private lazy var collabsibleTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TableViewHeader.self,
                           forHeaderFooterViewReuseIdentifier: TableViewHeader.reuseID)
        tableView.register(TableViewCell.self,
                           forCellReuseIdentifier: TableViewCell.reuseID)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = AppColor.gray10.uiColor
        return tableView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Setup Navigation Bar
    private func setupNavigationBar() {
        self.view.backgroundColor = AppColor.gray10.uiColor
        title = "Apple"
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        [collabsibleTableView].forEach {
            view.addSubview($0)
        }
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        collabsibleTableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
        }
    }
}
// MARK: - UITableViewDataSource, UITableViewDelegate
extension DetailViewCollabsibleViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].collapsed ? 0 : sections[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseID,
                                                       for: indexPath) as? TableViewCell
        else {
            fatalError("Could not cast to FaqTableViewCell")
        }
        let item: Item = sections[indexPath.section].items[indexPath.row]
        
        cell.nameLabel.text = item.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier:
                                                                    TableViewHeader.reuseID)
                as? TableViewHeader
        else {
            fatalError("Could not cast to FaqQuestionTableHeaderView")
        }
        
        header.iconImageView.image = sections[section].iconImage
        header.titleLabel.text = sections[section].name
        header.arrowLabel.text = ">"
        header.setCollapsed(sections[section].collapsed)
        
        header.section = section
        header.delegate = self
        
        return header
        
    }
}

extension DetailViewCollabsibleViewController: TableViewHeaderDelegate {
    func toggleSection(_ header: TableViewHeader, section: Int) {
        let collapsed = !sections[section].collapsed
        sections[section].collapsed = collapsed
        header.setCollapsed(collapsed)
    }
}
