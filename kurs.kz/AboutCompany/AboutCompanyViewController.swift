//
//  AboutCompanyViewController.swift
//  kurs.kz
//
//  Created by Bekzhan Askerbekov on 7/7/23.
//

import UIKit
import SnapKit

final class AboutCompanyViewController: UIViewController {
    
    private let service: AboutCompanyPageService
    
    // MARK: - UI
    private let aboutCompanyHeaderTextView: UITextView = {
        let textView = UITextView()
        textView.font = AppFont.bold.s14()
        textView.textAlignment = .center
        textView.isEditable = false
        textView.textContainerInset = UIEdgeInsets.zero // Set the textContainerInset to zero
        textView.textContainer.lineFragmentPadding = 0 // Set lineFragmentPadding to zero
        textView.textColor = AppColor.gray100.uiColor
        textView.backgroundColor = .clear
        return textView
    }()
    
    private let aboutCompanyTextView: UITextView = {
        let textView = UITextView()
        textView.font = AppFont.regular.s14()
        textView.textAlignment = .center
        textView.isEditable = false
        textView.textContainerInset = UIEdgeInsets.zero // Set the textContainerInset to zero
        textView.textContainer.lineFragmentPadding = 0 // Set lineFragmentPadding to zero
        textView.textColor = AppColor.gray100.uiColor
        textView.backgroundColor = .clear
        textView.showsVerticalScrollIndicator = false
        return textView
    }()
    
    // MARK: - Initializers
    init(service: AboutCompanyPageService) {
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
        fetchText()
    }
    
    // MARK: - Setup Navigation Bar
    private func setupNavigationBar() {
        self.title = "О компании"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: AppImage.arrow_back.uiImage,
                        style: .plain,
                        target: self,
                        action: #selector(backButtonDidPressed))
    }
    
    // MARK: - Setup Navigation Bar
    private func setupViews() {
        self.view.backgroundColor = AppColor.gray10.uiColor
        [aboutCompanyHeaderTextView, aboutCompanyTextView].forEach {
            view.addSubview($0)
        }
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        aboutCompanyHeaderTextView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.height.equalTo(16)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-16)
        }
        
        aboutCompanyTextView.snp.makeConstraints { make in
            make.top.equalTo(aboutCompanyHeaderTextView.snp.bottom).offset(12)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-16)
        }
    }
    
    // MARK: - Callback
    private func fetchText() {
        service.fetchAboutCompanyText { [weak self] result in
            switch result {
            case .success(let data):
                self?.aboutCompanyHeaderTextView.text = data.paragraph0
                self?.aboutCompanyTextView.text = """
                                                  \(data.paragraph1)\n\(data.paragraph2)\n
                                                  \(data.paragraph3)\n\(data.paragraph4)\n
                                                  \(data.paragraph5)\n\(data.paragraph6)\n
                                                  \n\(data.contacts.email)\n
                                                  \(data.contacts.address)\n
                                                  \(data.contacts.phone)
                                                  """
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Actions
    @objc private func backButtonDidPressed() {
        self.navigationController?.popViewController(animated: true)
    }
}
