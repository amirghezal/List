//
//  ListTokenLabel.swift
//  List
//
//  Created by Амир Гезаль on 24.02.2020.
//  Copyright © 2020 Амир Гезаль. All rights reserved.
//

import UIKit

class ListTokenLabel: UILabel {
    
    let topLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 25, weight: .semibold)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    let bottomLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = UserInfo.shared.username
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(_ type: String) {
        super.init(frame: .zero)
        configure(type)
    }
    
    func configure(_ type: String) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(topLabel)
        self.addSubview(bottomLabel)
        switch type {
        case Currencies.EOS.rawValue:
            topLabel.text = String(UserInfo.shared.EOSBalance)
        case Currencies.JNG.rawValue:
            topLabel.text = String(UserInfo.shared.JUNGLEBalance)
        default:
            break
        }
        topLabel.text! += (" " + type)
        
        NSLayoutConstraint.activate([
            topLabel.widthAnchor.constraint(equalTo: self.widthAnchor),
            topLabel.heightAnchor.constraint(equalToConstant: 25),
            topLabel.topAnchor.constraint(equalTo: self.topAnchor),
            
            bottomLabel.heightAnchor.constraint(equalToConstant: 17),
            bottomLabel.topAnchor.constraint(equalTo: topLabel.bottomAnchor, constant: 5),
            bottomLabel.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }
    
}
