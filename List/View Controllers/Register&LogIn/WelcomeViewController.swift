//
//  ViewController.swift
//  List
//
//  Created by Амир Гезаль on 20.02.2020.
//  Copyright © 2020 Амир Гезаль. All rights reserved.
//

import UIKit


final class WelcomeViewController: ListVC {
    
    private let createAccountButton = ListButton(title: Texts.shared.createAccount)
    private let addAccountButton = ListButton(title: Texts.shared.addAccount)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSelf()
    }
    
    func setupSelf() {
        addSubviews()
        configureLayouts()
        addActions()
    }
    
    func addActions() {
        createAccountButton.addTarget(self, action: #selector(handleCreateButton), for: .touchUpInside)
        addAccountButton.addTarget(self, action: #selector(handleAddButton), for: .touchUpInside)
        self.view.addGestureRecognizer(createSwipe())
    }

    
    //MARK: - actions
    @objc private func handleCreateButton() {
        let vc = CreateAccontViewController()
        vc.modalPresentationStyle = .popover
        present(vc, animated: true)
    }
    
    @objc private func handleAddButton() {
        let vc = TransparentViewController()
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    func createSwipe() -> UISwipeGestureRecognizer {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeUp))
        swipe.direction = .up
        return swipe
    }
    
    @objc func handleSwipeUp() {
        
        guard UserInfo.shared.isLoggedIn else { self.addAller(title: "Not logged", message: "Please log in"); return }
        let vc = WalletViewController()
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    func addSubviews() {
        contentView.addSubview(createAccountButton)
        contentView.addSubview(addAccountButton)
    }
    
    private func configureLayouts() {
        NSLayoutConstraint.activate([
            createAccountButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            createAccountButton.bottomAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -20),
            createAccountButton.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            createAccountButton.heightAnchor.constraint(equalToConstant: 50),
            
            addAccountButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            addAccountButton.topAnchor.constraint(equalTo: createAccountButton.bottomAnchor, constant: 40),
            addAccountButton.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            addAccountButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}


