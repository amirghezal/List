//
//  WalletCell.swift
//  List
//
//  Created by Амир Гезаль on 21.02.2020.
//  Copyright © 2020 Амир Гезаль. All rights reserved.
//

import UIKit

class WalletCell: UITableViewCell {
    
    let content: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(named: "CellColor")
        view.layer.cornerRadius = 20
        
        return view
    }()
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.text = "type transaction"
        
        return label
    }()
    
    let amountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.text = "+0.000000"
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
        self.backgroundColor = .clear
        self.isUserInteractionEnabled = false
        self.addSubview(content)
        self.content.addSubview(typeLabel)
        self.content.addSubview(amountLabel)
        NSLayoutConstraint.activate([
            content.widthAnchor.constraint(equalTo: self.widthAnchor),
            content.topAnchor.constraint(equalTo: self.topAnchor, constant: 2),
            content.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2),
            
            typeLabel.topAnchor.constraint(equalTo: content.topAnchor, constant: 10),
            typeLabel.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 25),
            typeLabel.heightAnchor.constraint(equalToConstant: 10),
            
            amountLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor, constant: 5),
            amountLabel.leadingAnchor.constraint(equalTo: content.leadingAnchor, constant: 25),
            amountLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
