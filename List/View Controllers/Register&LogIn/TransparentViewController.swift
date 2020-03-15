//
//  TransparentViewController.swift
//  List
//
//  Created by Амир Гезаль on 20.02.2020.
//  Copyright © 2020 Амир Гезаль. All rights reserved.
//

import UIKit

class TransparentViewController: ListVC {
    
    private let QRButton = ListButton(title: "Scan QR")
    private let manualButton = ListButton(title: "Manual")
    private let closerButton = ListButton(title: "Cancel")
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSelf()
    }
    
    func setupSelf() {
        QRButton.isUserInteractionEnabled = false
        view.layer.backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.9).cgColor
        setUpLayouts()
        addActions()
    }
    
    func addActions() {
        QRButton.addTarget(self, action: #selector(handleQRButton), for: .touchUpInside)
        manualButton.addTarget(self, action: #selector(handleManualButton), for: .touchUpInside)
        closerButton.addTarget(self, action: #selector(handleCloseButton), for: .touchUpInside)
    }
    
    @objc private func handleQRButton() {
        present(QRScannerViewController(), animated: true)
    }
    
    @objc private func handleManualButton() {
        present(ManualAddAccount(), animated: true)
    }
    
    @objc private func handleCloseButton() {
        dismiss(animated: true)
    }
    
    private func setUpLayouts() {
        let buttons = ([QRButton,manualButton,closerButton])
        for i in buttons {
            contentView.addSubview(i)
            i.backgroundColor = .white
            i.setTitleColor(.black, for: .normal)
            i.layer.cornerRadius = 10
        }
        QRButton.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        manualButton.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner]

        NSLayoutConstraint.activate([
            QRButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            QRButton.heightAnchor.constraint(equalToConstant: 50),
            QRButton.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            QRButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -181),
            
            manualButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            manualButton.heightAnchor.constraint(equalToConstant: 50),
            manualButton.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            manualButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -130),
            
            closerButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            closerButton.heightAnchor.constraint(equalToConstant: 50),
            closerButton.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            closerButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
        ])
    }
    
}
