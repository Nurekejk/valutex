//
//  NationalBankCourseViewController.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 02.08.2023.
//

import UIKit
import WebKit

final class NationalBankCourseViewController: UIViewController, WKNavigationDelegate {
    
    // MARK: - UI
    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.navigationDelegate = self
        return webView
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Setup Navigation Bar
    private func setupNavigation() {
        self.title = "Курс Национального Банка"
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
        view.addSubview(webView)
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    // MARK: - Actions
    @objc private func backButtonDidPressed() {
        self.navigationController?.popViewController(animated: true)
    }
}
