//
//  CollapsibleTableViewController.swift
//  kurs.kz
//
//  Created by Diar Orynbek on 03.08.2023.
//

import UIKit
import SnapKit
import CollapsibleTableSectionViewController
import ProgressHUD

final class DetailViewController: UIViewController {
    
    // MARK: - Properties
    private let service: DetailPageService
    private var sections = [DetailSection]()
    private var currencies = [CurrencyElement]()
    
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
        tableView.register(CurrencyInformationTableHeaderView.self,
                           forHeaderFooterViewReuseIdentifier: CurrencyInformationTableHeaderView.reuseID)
        tableView.register(CurrencyInformationTableViewCell.self,
                           forCellReuseIdentifier: CurrencyInformationTableViewCell.reuseIdentifier)
        tableView.register(CurrencyInformationTableFooterView.self,
                           forHeaderFooterViewReuseIdentifier: CurrencyInformationTableFooterView.reuseID)
        tableView.register(FeedbackTableViewCell.self,
                           forCellReuseIdentifier: FeedbackTableViewCell.reuseID)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = AppColor.gray10.uiColor
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
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
        
        ProgressHUD.showProgress(1.0)
        fetchCurrencyDetails()
        fetchExchangerDetails()
        ProgressHUD.dismiss()
        
        setupViews()
        setupConstraints()
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
        let callButton = UIBarButtonItem(image: AppImage.call_image.uiImage,
                                         style: .plain,
                                         target: self,
                                         action: #selector(callButtonDidPressed))
        let shareButton = UIBarButtonItem(image: AppImage.share_image.uiImage,
                                          style: .plain,
                                          target: self,
                                          action: #selector(shareButtonDidPressed))
        navigationItem.rightBarButtonItems = [shareButton, callButton]
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
            make.top.leading.equalToSuperview().offset(16)
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
                ProgressHUD.show(icon: .failed)
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchCurrencyDetails() {
        service.fetchCurrencyInformation(officeID: 1) { result in
            switch result {
            case .success(let currencyDetails):
                self.currencies = currencyDetails
            case .failure(let error):
                ProgressHUD.show(icon: .failed)
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
    
    private func getHoursString(dateString: String) -> String {
        let start = dateString.index(dateString.startIndex, offsetBy: 11)
        let end = dateString.index(dateString.endIndex, offsetBy: -3)
        let range = start..<end
        let timeString = dateString[range]
        return String(timeString)
    }
    
    // MARK: - Actions
    @objc private func callButtonDidPressed() {
        let alert = UIAlertController(title: "Вы нажали на кнопку позвонить.",
                                      message: "",
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc private func shareButtonDidPressed() {
        let alert = UIAlertController(title: "Вы нажали на кнопку поделиться.",
                                      message: "",
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension DetailViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count + 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section < SectionNumber.two.rawValue || section == SectionNumber.three.rawValue {
            return 1
        } else if section == SectionNumber.two.rawValue {
            return currencies.count
        }
        return sections[section - 4].collapsed ? 0 : sections[section - 4].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case SectionNumber.zero.rawValue:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ExchangerScreenTableViewCell.reuseIdentifier,
                for: indexPath) as? ExchangerScreenTableViewCell
            else {
                fatalError("Could not cast to ExchangerScreenTableViewCell")
            }
            return cell
        case SectionNumber.one.rawValue:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ExchangerScreenTextTableViewCell.reuseIdentifier,
                for: indexPath) as? ExchangerScreenTextTableViewCell
            else {
                fatalError("Could not cast to ExchangerScreenTextTableViewCell")
            }
            return cell
        case SectionNumber.two.rawValue:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CurrencyInformationTableViewCell.reuseIdentifier,
                for: indexPath) as? CurrencyInformationTableViewCell
            else {
                fatalError("Could not cast to CurrencyInformationTableViewCell")
            }
            cell.currency = currencies[indexPath.row]
            return cell
        case SectionNumber.three.rawValue:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: FeedbackTableViewCell.reuseID,
                for: indexPath) as? FeedbackTableViewCell
            else {
                fatalError("Could not cast to FeedbackTableViewCell")
            }
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailTableViewCell.reuseID,
                                                           for: indexPath) as? DetailTableViewCell
            else {
                fatalError("Could not cast to DetailTableViewCell")
            }
            let item = sections[indexPath.section - 4].items[indexPath.row]
            cell.nameLabel.text = item
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section < SectionNumber.two.rawValue || section == SectionNumber.three.rawValue {
            return UIView()
        } else if section == SectionNumber.two.rawValue {
            guard let header = tableView.dequeueReusableHeaderFooterView(
                withIdentifier: CurrencyInformationTableHeaderView.reuseID)
                    as? CurrencyInformationTableHeaderView
            else {
                fatalError("Could not cast to CurrencyInformationTableHeaderView")
            }
            return header
        }
        
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier:
                                                                        DetailTableViewHeader.reuseID)
                                                                        as? DetailTableViewHeader
        else {
            fatalError("Could not cast to DetailTableViewHeader")
        }
        header.titleLabel.text = sections[section - 4].name
        header.setCollapsed(sections[section - 4].collapsed)
        header.section = section
        header.detailSection = sections[section - 4]
        header.delegate = self
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section < SectionNumber.two.rawValue {
            return 0
        } else if section == SectionNumber.three.rawValue {
            return 16
        } else if section == SectionNumber.two.rawValue {
            return 36
        }
        return 54
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        if section == SectionNumber.two.rawValue {
            guard let footer = tableView.dequeueReusableHeaderFooterView(
                withIdentifier: CurrencyInformationTableFooterView.reuseID)
                    as? CurrencyInformationTableFooterView
            else {
                fatalError("Could not cast to CurrencyInformationTableFooterView")
            }
            return footer
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section < SectionNumber.two.rawValue || section == SectionNumber.three.rawValue {
            return 16
        } else if section == SectionNumber.two.rawValue {
            return 34
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == SectionNumber.three.rawValue {
            self.navigationController?.pushViewController(RateViewController(),
                                                          animated: true)
        }
    }
}

// MARK: - CollapsibleTableViewHeaderDelegate
extension DetailViewController: CollapsibleTableViewHeaderDelegate {
    func toggleSection(_ header: DetailTableViewHeader, section: Int) {
        let collapsed = !sections[section - 4].collapsed
        sections[section - 4].collapsed = collapsed
        header.setCollapsed(collapsed)
        exchangerDetailsTableView.reloadData()
    }
}
