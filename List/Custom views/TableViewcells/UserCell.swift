//
//  UserCell.swift
//  List
//
//  Created by Амир Гезаль on 03.03.2020.
//  Copyright © 2020 Амир Гезаль. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {
    
    let content: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let username: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        label.text = "Usgername"
        label.textColor = .label
        
        return label
    }()
    
    let balance: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15, weight: .thin)
        label.text = "0.0001 EOS"
        label.textColor = .label
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        self.addSubview(content)
        self.content.addSubview(username)
        self.content.addSubview(balance)
        NSLayoutConstraint.activate([
            content.widthAnchor.constraint(equalTo: self.widthAnchor),
            content.heightAnchor.constraint(equalTo: self.heightAnchor),
            content.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            content.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            username.heightAnchor.constraint(equalToConstant: 33),
            username.topAnchor.constraint(equalTo: content.topAnchor, constant: 5),
            username.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 20),
            username.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -20),
            
            balance.heightAnchor.constraint(equalToConstant: 15),
            balance.topAnchor.constraint(equalTo: username.bottomAnchor, constant: 5),
            balance.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 20),
            balance.trailingAnchor.constraint(equalTo: content.trailingAnchor, constant: -20),
        ])
    }
}
