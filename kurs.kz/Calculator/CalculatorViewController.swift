//
//  CalculatorViewController.swift
//  kurs.kz
//
//  Created by Акерке on 19.07.2023.
//

import UIKit

class CalculatorViewController: UIViewController {

    // MARK: - UI

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource  = self
        tableView.delegate = self
        tableView.register(CalculatorTableViewCell.self,
                           forCellReuseIdentifier: CalculatorTableViewCell.reuseIdentifier)
        tableView.rowHeight = 87
        //        tableView.sectionHeaderHeight = 18
        tableView.separatorStyle = .none
        return tableView
    }()
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
    }
    // MARK: - Setup Views

    private func setupViews() {
        view.addSubview(tableView)
        tableView.backgroundColor = .systemGray6
    }

    // MARK: - Setup Constraints

    private func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
// MARK: - UITableViewDataSource, UITableViewDelegate

extension CalculatorViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CalculatorTableViewCell.reuseIdentifier,
                                                 for: indexPath) as? CalculatorTableViewCell
        return cell ?? UITableViewCell()
    }

    //        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    //            let width = UIScreen.main.bounds.width
    //            let view = CalculatorSectionHeaderView(frame: CGRect(x: 0, y: 0, width: width, height: 0))
    //            return view
    //        }

}
