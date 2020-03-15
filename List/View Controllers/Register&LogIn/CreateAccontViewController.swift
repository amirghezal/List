//
//  CreateAccontViewController.swift
//  List
//
//  Created by Амир Гезаль on 20.02.2020.
//  Copyright © 2020 Амир Гезаль. All rights reserved.
//

import UIKit
import eosswift

class CreateAccontViewController: ListVC {
    
    private let usernameRequirments = ListLabel(ofSize: 12,
                                                ofWeight: .regular,
                                                ofColor: .secondaryLabel,
                                                Texts.shared.usernameRequirments)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSelf()
    }
    
    func setupSelf() {
        self.vcName.text = Texts.shared.createAccount
        textField.textField.delegate = self
        addSubviews()
        addBottomButton(Texts.shared.createAccount)
        addTopTextField(Texts.shared.createAccount)
        setupLayouts()
        addActions()
    }
    
    @objc func handleBottomButton() {
        guard let username = textField.textField.text?.lowercased(), username != "" else { self.addAller(title: "Empty field", message: "Please enter an username"); return }
        guard username.count == 12 else { self.addAller(title: "Wrong format", message: "Username must contain 12 symbols"); return }
        guard NetworkManager.shared.isUsernameAndPasswordValid(with: username, password: "") else { self.addAller(title: "Wrong format", message: "Please, follow the instruction below"); return }
        
        let privateKey = try! EOSPrivateKey()
        let publicKey = privateKey.publicKey
        NetworkManager.shared.isUsernameFree(username: username) { [weak self] result in
            guard self === self else { return }
            switch result {
            case .success(_):
                NetworkManager.shared.registerAccount(username: username, publicKey: publicKey.base58) { resultOfReg in
                    switch resultOfReg {
                    case .success(_):
                        self?.addAllertWithCLosure(title: "Please save you keys", message: "Public: \(publicKey.base58)\nPrivate: \(privateKey.base58)", closure: {_ in
                            NetworkManager.shared.getBalanceAndSaveUser(for: username, privateKey: privateKey.base58) { result in
                                switch result {
                                case .success(_):
                                    DispatchQueue.main.async {          
                                        let vc = WalletViewController()
                                        vc.modalPresentationStyle = .fullScreen
                                        self?.present(vc, animated: true, completion: nil)
                                    }
                                default: break
                                }
                            }
                        })
                    case .failure(_): self?.addAller(title: "Error in creating account", message: "Something went wrong here")
                    }
                }
            case .failure(_): self?.addAller(title: "Error in creating account", message: "Something went wrong")
            }
        }
    }
    
    func proceed() {
        DispatchQueue.main.async {
            let vc = WalletViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
    }
    
    func addSubviews() {
        contentView.addSubview(usernameRequirments)
    }
    
    func addActions() {
        addSwipes()
        vcBottomButton.addTarget(self, action: #selector(handleBottomButton), for: .touchUpInside)
    }
    
    func setupLayouts() {
        NSLayoutConstraint.activate([
            usernameRequirments.topAnchor.constraint(equalTo: self.textField.bottomAnchor, constant: 20),
            usernameRequirments.widthAnchor.constraint(equalTo: contentView.widthAnchor)
        ])
    }
}
//MARK: - add gustrures
private extension CreateAccontViewController {
    
    func addSwipes() {
        self.view.addGestureRecognizer(createDownSwipe())
        self.view.addGestureRecognizer(createRightSwipe())
        self.view.addGestureRecognizer(createTap())
    }
    
    func createDownSwipe() -> UISwipeGestureRecognizer {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(dismissSelf))
        swipe.direction = .down
        swipe.numberOfTouchesRequired = 1
        
        return swipe
    }
    
    func createRightSwipe() -> UIGestureRecognizer {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(dismissSelf))
        swipe.direction = .left
        swipe.numberOfTouchesRequired = 1
        
        return swipe
    }
    
    @objc func dismissSelf() {
        dismiss(animated: true)
    }
    
    @objc func dismissKeyboard() {
        //textField.textField.endEditing(true)
    }
    
    func createTap() -> UITapGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        return tap
    }
}

//MARK: - textfield delegate
extension CreateAccontViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
    
}
