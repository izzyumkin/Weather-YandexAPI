//
//  DetailViewController.swift
//  Weather-YandexAPI
//
//  Created by Иван Изюмкин on 18.09.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    var tableView = UITableView(frame: CGRect.zero, style: .insetGrouped)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGroupedBackground
        view.addSubview(tableView)
        
        setTableViewConstraints()
    }
    
    func setTableViewConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}
