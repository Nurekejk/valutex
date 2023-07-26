//
//  AboutCompanyViewController.swift
//  kurs.kz
//
//  Created by Bekzhan Askerbekov on 7/7/23.
//

import UIKit
import SnapKit

final class AboutCompanyViewController: UIViewController {
    
    // MARK: - UI
    private let aboutCompanyTextView: UITextView = {
        let textView = UITextView()
        textView.text = """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt
        ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco
        laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in
        voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat
        non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
        """
        textView.font = AppFont.regular.s14()
        textView.textAlignment = .justified
        textView.isEditable = false
        textView.textContainerInset = UIEdgeInsets.zero // Set the textContainerInset to zero
        textView.textContainer.lineFragmentPadding = 0 // Set lineFragmentPadding to zero
        textView.textColor = AppColor.gray100.uiColor
        textView.backgroundColor = AppColor.gray10.uiColor
        return textView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupView()
        setupConstraints()
    }
    
    // MARK: - Setup
    
    private func setupNavigationBar() {
        self.view.backgroundColor = AppColor.gray10.uiColor
        self.title = "О компании"
    }
        
    private func setupView() {
        view.addSubview(aboutCompanyTextView)
    }
        
    private func setupConstraints() {
        aboutCompanyTextView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(120)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-16)
            }
        }
    }
