//
//  CollapsibleTableViewController.swift
//  kurs.kz
//
//  Created by Diar Orynbek on 03.08.2023.
//

import UIKit
import SnapKit
import CollapsibleTableSectionViewController

final class DetailViewCollabsibleViewController: UIViewController {
 
    public var sectionsData: [Section] = [
        Section(name: "Телефон", iconImage: UIImage(named: "phone"),
                items: [
                    Item(name: "+7-701-476-99-99"),
                    Item(name: "+7-701-476-99-99 ")
                ]),
        Section(name: "Время работы", iconImage: UIImage(named: "clock"),
                items: [
                    Item(name: "Пн - 09:00 - 21:00"),
                    Item(name: "Вт - 09:00 - 21:00"),
                    Item(name: "Ср - 09:00 - 21:00"),
                    Item(name: "Чт - 09:00 - 21:00"),
                    Item(name: "Пт - 09:00 - 21:00"),
                    Item(name: "Сб -  выходной"),
                    Item(name: "Вс -  выходной")
                ]),
        Section(name: "Email", iconImage: UIImage(named: "whatsapp"),
                items: [
                    Item(name: "mail@mail.ru")
                ])
    ]

    var sections = [Section]()
    
    // MARK: - UI
    private lazy var exchangerDetailsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(DetailTableViewHeader.self,
                           forHeaderFooterViewReuseIdentifier: DetailTableViewHeader.reuseID)
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
        title = "Apple"
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        self.view.backgroundColor = AppColor.gray10.uiColor
        [exchangerDetailsTableView].forEach {
            view.addSubview($0)
        }
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        exchangerDetailsTableView.snp.makeConstraints { make in
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
                                                                    DetailTableViewHeader.reuseID)
                as? DetailTableViewHeader
        else {
            fatalError("Could not cast to FaqQuestionTableHeaderView")
        }
        
        header.titleLabel.text = sections[section].name
        header.setCollapsed(sections[section].collapsed)
        
        header.section = section
        header.delegate = self
        
        return header
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 54
    }
}

extension DetailViewCollabsibleViewController: TableViewHeaderDelegate {
    func toggleSection(_ header: DetailTableViewHeader, section: Int) {
        let collapsed = !sections[section].collapsed
        sections[section].collapsed = collapsed
        header.setCollapsed(collapsed)
        exchangerDetailsTableView.reloadData()
    }
}
