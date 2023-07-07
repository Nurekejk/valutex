//
//  AboutCompanyViewController.swift
//  kurs.kz
//
//  Created by Bekzhan Askerbekov on 7/7/23.
//

import UIKit
import SnapKit

class AboutCompanyViewController: UIViewController {

    private let aboutCompanyTextView: UITextView = {
        let textView = UITextView()
        textView.text = """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt
        ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco
        laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in
        voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat
        non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
        """
        textView.font = .systemFont(ofSize: 18)
        textView.textAlignment = .justified
        textView.isEditable = false
        textView.textContainerInset = UIEdgeInsets.zero // Set the textContainerInset to zero
        textView.textContainer.lineFragmentPadding = 0 // Set lineFragmentPadding to zero
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = "О компании"
        setupLayout()
    }

    private func setupLayout() {
        view.addSubview(aboutCompanyTextView)

        aboutCompanyTextView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(16)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-16)
        }
    }
}
