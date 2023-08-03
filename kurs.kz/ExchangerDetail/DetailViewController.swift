//
//  CollapsibleTableViewController.swift
//  kurs.kz
//
//  Created by Diar Orynbek on 03.08.2023.
//

import UIKit
import SnapKit
import CollapsibleTableSectionViewController

final class DetailViewController: UIViewController, TableViewHeaderDelegate {
    
    private let service: DetailPageService
    var sections = [Section]()
    
    // MARK: - UI
    private lazy var exchangerDetailsTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(DetailTableViewHeader.self,
                           forHeaderFooterViewReuseIdentifier: DetailTableViewHeader.reuseID)
        tableView.register(DetailTableViewCell.self,
                           forCellReuseIdentifier: DetailTableViewCell.reuseID)
        tableView.register(ExchangerScreenTableViewCell.self,
                           forCellReuseIdentifier: ExchangerScreenTableViewCell.reuseIdentifier)
        tableView.register(ExchangerScreenTextTableViewCell.self,
                           forCellReuseIdentifier: ExchangerScreenTextTableViewCell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = AppColor.gray10.uiColor
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // MARK: - Initializers
    init(service: DetailPageService) {
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
        fetchExchangerDetails()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        exchangerDetailsTableView.layer.cornerRadius = 8.0
    }
    
    // MARK: - Setup Navigation Bar
    private func setupNavigationBar() {
        self.title = "Обменники"
        edgesForExtendedLayout = []
        self.navigationItem.leftBarButtonItem =
        UIBarButtonItem(image: AppImage.arrow_back.uiImage,
                        style: .plain,
                        target: self,
                        action: #selector(backButtonDidPressed))
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
        exchangerDetailsTableView.estimatedRowHeight = 45
        exchangerDetailsTableView.rowHeight = UITableView.automaticDimension
        if #available(iOS 15.0, *) {
            exchangerDetailsTableView.sectionHeaderTopPadding = 1.0
        }
        
        exchangerDetailsTableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100)
            make.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Actions
    @objc private func backButtonDidPressed() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - Callback
    private func fetchExchangerDetails() {
        service.fetchDetails(officeID: 1) { result in
            switch result {
            case .success(let details):
                self.setSectionsData(details: details)
                self.exchangerDetailsTableView.reloadData()
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // swiftlint:disable all
    private func setSectionsData(details: Details) {
        // Phone Section
        let phoneSection = Section(name: "Телефоны",
                                   iconImage: AppImage.call.uiImage,
                                   items: details.contacts)
        
        // Working Hours Section
        var workingHours = [String]()
        var dayOfWeek = 0
        details.schedule.forEach { time in
            var dayString = ""
            switch dayOfWeek {
            case 0:
                dayString = "Пн"
            case 1:
                dayString = "Вт"
            case 2:
                dayString = "Ср"
            case 3:
                dayString = "Чт"
            case 4:
                dayString = "Пт"
            case 5:
                dayString = "Сб"
            case 6:
                dayString = "Вс"
            default:
                dayString = ""
            }
            let fullTime = """
                            \(dayString) - \(self.convertDate(dateString: time.from)) - \(self.convertDate(dateString: time.to))
                           """
            dayOfWeek += 1
            workingHours.append(fullTime)
        }
        let workingHoursSection = Section(name: "Время работы",
                                          iconImage: AppImage.clock.uiImage,
                                          items: workingHours)
        
        // Emails Section
        var emails = [String]()
        emails.append(details.email)
        let emailSection = Section(name: "Email",
                                   iconImage: AppImage.sms.uiImage,
                                   items: emails)
        
        // Website Section
        var websites = [String]()
        websites.append(details.webSite)
        let websiteSection = Section(name: "Web-site",
                                     iconImage: AppImage.link_2.uiImage,
                                     items: websites)
        
        // WhatsApp Section
        let whatsAppSection = Section(name: "Whatsapp",
                                      iconImage: AppImage.messenger.uiImage,
                                      items: details.whatsapp)
        
        [phoneSection, workingHoursSection, emailSection,
         websiteSection, whatsAppSection].forEach {
            self.sections.append($0)
        }
    }
    // swiftlint:enable all
    
    private func convertDate(dateString: String) -> String {
        let start = dateString.index(dateString.startIndex, offsetBy: 11)
        let end = dateString.index(dateString.endIndex, offsetBy: -3)
        let range = start..<end

        let timeString = dateString[range]
        return String(timeString)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count + 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section < SectionNumber.two.rawValue {
            return 1
        }
        return sections[section-2].collapsed ? 0 : sections[section-2].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ExchangerScreenTableViewCell.reuseIdentifier,
                for: indexPath) as? ExchangerScreenTableViewCell
            else {
                fatalError("Could not cast to ExchangerScreenTableViewCell")
            }
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ExchangerScreenTextTableViewCell.reuseIdentifier,
                for: indexPath) as? ExchangerScreenTextTableViewCell
            else {
                fatalError("Could not cast to ExchangerScreenTextTableViewCell")
            }
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.reuseID,
                                                           for: indexPath) as? DetailTableViewCell
            else {
                fatalError("Could not cast to DetailTableViewCell")
            }
            let item = sections[indexPath.section-2].items[indexPath.row]
            cell.nameLabel.text = item
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section < SectionNumber.two.rawValue {
            return UIView()
        }
        
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier:
                                                                        DetailTableViewHeader.reuseID)
                as? DetailTableViewHeader
        else {
            fatalError("Could not cast to FaqQuestionTableHeaderView")
        }
        
        header.titleLabel.text = sections[section-2].name
        header.setCollapsed(sections[section-2].collapsed)
        
        header.section = section
        header.detailSection = sections[section-2]
        header.delegate = self
        
        return header
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section < SectionNumber.two.rawValue ? 0 : 54
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section > SectionNumber.one.rawValue ? 0 : 16
    }
}

// MARK: - CollapsibleTableViewHeaderDelegate
extension DetailViewController: CollapsibleTableViewHeaderDelegate {
    func toggleSection(_ header: DetailTableViewHeader, section: Int) {
        let collapsed = !sections[section-2].collapsed
        sections[section-2].collapsed = collapsed
        header.setCollapsed(collapsed)
        exchangerDetailsTableView.reloadData()
    }
}
