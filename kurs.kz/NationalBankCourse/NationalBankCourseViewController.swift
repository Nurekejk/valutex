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
        setupViews()
        setupConstraints()
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
    
}
