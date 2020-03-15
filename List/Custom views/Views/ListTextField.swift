//
//  ListTextField.swift
//  List
//
//  Created by Амир Гезаль on 20.02.2020.
//  Copyright © 2020 Амир Гезаль. All rights reserved.
//

import UIKit

class ListTextField: UIView {
    
    var textField : UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter username"
        textField.textAlignment = .center
        textField.backgroundColor = .systemBackground
        textField.textColor = .label
        textField.layer.borderWidth = 2
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = UIColor.systemGray.cgColor
        textField.tintColor = .darkGray
        textField.autocorrectionType = .no
        
        return textField
    }()
    
    var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .label
        label.backgroundColor = .systemBackground
        label.font = UIFont.systemFont(ofSize: 15)
        label.layer.zPosition = 200
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(_ title: String) {
        super.init(frame: .zero)
        label.text = title
        configure()
    }
    
    private func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        setupLayouts()
    }
    
    private func setupLayouts() {
        self.addSubview(label)
        self.addSubview(textField)
            NSLayoutConstraint.activate([
            textField.widthAnchor.constraint(equalTo: self.widthAnchor),
            textField.heightAnchor.constraint(equalTo: self.heightAnchor),
            textField.topAnchor.constraint(equalTo: self.topAnchor),
            textField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            label.heightAnchor.constraint(equalToConstant: 21),
            label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15),
            label.bottomAnchor.constraint(equalTo: self.topAnchor, constant: 10)
        ])
    }
}

