//
//  NewsListView.swift
//  News App
//
//  Created by Nishigandha Bhushan Jadhav on 01/07/24.
//

import UIKit

final class NewsListView: UIView {

    init() {
       super.init(frame: .zero)
       buildUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var tableView : UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .systemBackground
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 400
        tableView.rowHeight = UITableView.automaticDimension
        return tableView
    }()
    let spinner = UIActivityIndicatorView(style: .large)
    let refreshControl = UIRefreshControl()

    private func buildUI() {
        [tableView, spinner].forEach {
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor)])
    }
    

}


enum Layout {// Constants describes spacing, paddings and picture sizes
    static let spacing: CGFloat = 8
    static let offset: CGFloat = spacing * 2
    static let placeholderSize: CGSize = CGSize(width: 44.0, height: 44.0)
}
