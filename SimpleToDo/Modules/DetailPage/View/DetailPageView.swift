//
//  DetailPageView.swift
//  SimpleToDo
//
//  Created by Артур Байбиков on 06.10.2023.
//

import UIKit

class DetailPageView: UIView {
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(DetailPageTableViewCell.self, forCellReuseIdentifier: Resources.detailTableReuseId)
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(tableView)
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
