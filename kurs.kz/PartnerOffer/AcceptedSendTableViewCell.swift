//
//  AcceptedSendTableViewCell.swift
//  kurs.kz
//
//  Created by Aigerim Abitayeva on 16.07.2023.
//

import UIKit

class AcceptedSendTableViewCell: UITableViewCell {
    
    // MARK: - State
    static let reuseID = String(describing: AcceptedSendTableViewCell.self)
    
    // MARK: - UI
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    private func setupViews() {
        
    }
    
    // MARK: - Setup Constraints
    private func setupConstraints() {
        
    }
}
