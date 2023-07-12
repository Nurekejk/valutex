//
//  ProfileViewController.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 12.07.2023.
//

import UIKit
import SnapKit

final class ProfileViewController: UIViewController {
    
    // MARK: - UI
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = .white
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
