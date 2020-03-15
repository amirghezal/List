//
//  SuccesViewController.swift
//  List
//
//  Created by Амир Гезаль on 21.02.2020.
//  Copyright © 2020 Амир Гезаль. All rights reserved.
//

import UIKit

class SuccesViewController: ListVC {
    
    var transactionID: String!
    var username: String! 
    private lazy var transactionIDLabel = ListLabel(ofSize: 15, ofWeight: .regular, ofColor: .label, self.transactionID)
    private lazy var usernameLabel = ListLabel(ofSize: 25, ofWeight: .regular, ofColor: .label, self.username)
    
    private lazy var imageView: UIImageView = {
        let temp = UIImage(systemName: "plus")
        let image = temp?.withTintColor(.green, renderingMode: .alwaysOriginal)
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupLayouts()
        transactionIDLabel.numberOfLines = 0
        transactionIDLabel.adjustsFontSizeToFitWidth = true
        transactionIDLabel.textAlignment = .center
    }
    
    
    @objc private func sendCoins() {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true)
    }
    
    
    func addSubviews() {
        contentView.addSubview(transactionIDLabel)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(imageView)
        vcBottomButton.addTarget(self, action: #selector(sendCoins), for: .touchUpInside)
        addBottomButton("OK")
    }
    
    func setupLayouts() {
        NSLayoutConstraint.activate([
            transactionIDLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
            transactionIDLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            transactionIDLabel.heightAnchor.constraint(equalToConstant: 30),
            transactionIDLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: transactionIDLabel.bottomAnchor, constant: 20),
            usernameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            usernameLabel.heightAnchor.constraint(equalToConstant: 25),
            
            imageView.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 100),
            imageView.widthAnchor.constraint(equalToConstant:150),
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
    }
}
