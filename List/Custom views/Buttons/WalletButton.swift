//
//  WalletButton.swift
//  List
//
//  Created by Амир Гезаль on 21.02.2020.
//  Copyright © 2020 Амир Гезаль. All rights reserved.
//

import UIKit

public class WalletButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let image : UIImageView = {
        let tempimage = UIImage(systemName: "plus")
        let image = tempimage?.withTintColor(UIColor.label, renderingMode: .alwaysOriginal)
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderColor = UIColor.darkGray.cgColor
        imageView.layer.borderWidth = 0.1
        imageView.layer.cornerRadius = 5
        
        return imageView
    }()
    
    let label : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .thin)
        label.textAlignment = .center
        
        return label
    }()
    
    init(_ image: UIImage?, _ title: String) {
        super.init(frame: .zero)
        configure(image, title)
    }
    
    func configure(_ image: UIImage?, _ title: String) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .systemBackground
        if image != nil {
            self.image.image = image
        }
        label.text = title
        setupLayouts()
    }
    
    func setupLayouts() {
        self.addSubview(image)
        self.addSubview(label)
        NSLayoutConstraint.activate([
            image.widthAnchor.constraint(equalToConstant: 40),
            image.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            image.heightAnchor.constraint(equalTo: image.widthAnchor),
            image.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            
            label.widthAnchor.constraint(equalTo: self.widthAnchor),
            label.heightAnchor.constraint(equalToConstant: 20),
            label.topAnchor.constraint(equalTo: image.bottomAnchor),
            label.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
}
