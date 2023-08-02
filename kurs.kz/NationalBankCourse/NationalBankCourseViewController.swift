//
//  NationalBankCourseViewController.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 02.08.2023.
//

import UIKit
import WebKit
import ProgressHUD

final class NationalBankCourseViewController: UIViewController, WKNavigationDelegate {
    
    private let service: NationalBankPageService
    
    // MARK: - UI
    private lazy var webView: WKWebView = {
        let webView = WKWebView()
        webView.navigationDelegate = self
        return webView
    }()
    
    // MARK: - Initializers
    init(service: NationalBankPageService) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureWebView()
        setupNavigation()
        setupViews()
        setupConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        ProgressHUD.dismiss()
    }
    
    private func configureWebView() {
        self.showProgress()
        service.fetchNationalBankUrl { result in
            switch result {
            case .success(let nationalBankUrl):
                guard let url = URL(string: nationalBankUrl.url) else {
                    fatalError("URL error!")
                }
                self.webView.load(URLRequest(url: url))
                self.webView.allowsBackForwardNavigationGestures = true
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
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

// MARK: - ProgressHudProtocol
extension NationalBankCourseViewController: ProgressHudProtocol {
    func showSuccess() {
        ProgressHUD.show(icon: .succeed)
    }
    
    func showFailure() {
        ProgressHUD.show(icon: .failed)
    }
    
    func showProgress() {
        ProgressHUD.showProgress("Загружаем...", 1.0)
    }
}
