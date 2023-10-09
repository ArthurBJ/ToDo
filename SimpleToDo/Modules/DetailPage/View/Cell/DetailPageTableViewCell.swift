//
//  DetailPageTableViewCell.swift
//  SimpleToDo
//
//  Created by Артур Байбиков on 06.10.2023.
//

import UIKit

class DetailPageTableViewCell: UITableViewCell {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = Resources.Colors.titleFontColor
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let checkBoxButton: UIImageView = {
        let view = UIImageView()
        view.tintColor = Resources.Colors.titleFontColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    var isDone: Bool? {
        didSet {
            switchCheckBox()
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()
        setConstraints()
    }
    
    private func switchCheckBox() {
        isDone == true ? (checkBoxButton.image = Resources.Images.checkBoxDone) : (checkBoxButton.image = Resources.Images.checkBox)
    }
    
    private func setupView() {
        contentView.addSubview(checkBoxButton)
        contentView.addSubview(nameLabel)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            checkBoxButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            checkBoxButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: checkBoxButton.trailingAnchor, constant: 10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
