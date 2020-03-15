//
//  WalletTopView.swift
//  List
//
//  Created by Амир Гезаль on 20.02.2020.
//  Copyright © 2020 Амир Гезаль. All rights reserved.
//

import UIKit

class WalletTopView: UIView {
    
    
    
    let image : UIImageView = {
        let configuration = UIImage.SymbolConfiguration(scale: .small)
        let image = UIImage(systemName: "creditcard", withConfiguration: configuration)!.withTintColor(.label, renderingMode: .alwaysOriginal)
        let view = UIImageView(image: image)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Add account"
        label.textColor = .label
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(image)
        self.addSubview(label)
        NSLayoutConstraint.activate([
            image.heightAnchor.constraint(equalTo: self.heightAnchor),
            image.widthAnchor.constraint(equalTo: image.heightAnchor),
            image.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            label.leadingAnchor.constraint(equalTo: image.trailingAnchor),
            label.heightAnchor.constraint(equalTo: self.heightAnchor)
        ])
    }
    
}
