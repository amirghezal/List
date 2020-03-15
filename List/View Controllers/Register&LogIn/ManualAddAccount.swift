//
//  ManualAddAccount.swift
//  List
//
//  Created by Амир Гезаль on 20.02.2020.
//  Copyright © 2020 Амир Гезаль. All rights reserved.
//

import UIKit

class ManualAddAccount: ListVC {
    
    let keyTextField = ListTextField("Private key")
    var array: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSelf()
    }
    
    func setupSelf() {
        self.vcName.text = Texts.shared.addAccount
        keyTextField.textField.placeholder = "Enter you privete key"
        self.addBottomButton(Texts.shared.addAccount)
        self.addTopTextField("Username")
        textField.textField.delegate = self
        keyTextField.textField.delegate = self
        setupLayouts()
        addActions()
    }
    
    func setupLayouts() {
        contentView.addSubview(keyTextField)
        NSLayoutConstraint.activate([
            keyTextField.topAnchor.constraint(equalTo: self.textField.bottomAnchor, constant: 50),
            keyTextField.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            keyTextField.heightAnchor.constraint(equalToConstant: 45)
        ])
    }
    
    func addActions() {
        vcBottomButton.addTarget(self, action: #selector(handleCreateButton), for: .touchUpInside)
        self.view.addGestureRecognizer(createTap())
    }
    
    @objc private func handleCreateButton() {
        guard let text = textField.textField.text?.lowercased(), text != "" else { self.addAller(title: "Error!", message: "Empty username"); return }
        DispatchQueue.main.async {
            NetworkManager.shared.addAccount(text) { result in
                switch result {
                case .failure(let error):
                    self.addAller(title: "Error!", message: error.localizedDescription)
                case .success(let isFree, let user):
                    switch isFree {
                    case false:
                        UserInfo.shared.EOSBalance = user!.EOSBalance
                        UserInfo.shared.username = text
                        UserInfo.shared.choosedCurrency = Currencies.EOS.rawValue;
                        UserInfo.shared.privateKey = self.keyTextField.textField.text!
                        let user = User(userName: text, privateKey: self.keyTextField.textField.text!)
                        var isMatched = false
                        for User in LocalData.shared.users {
                            if (User.userName == user.userName) || (User.privateKey == user.privateKey) {
                                isMatched = true
                            }
                        }
                        guard isMatched == false else { self.addAller(title: "Error!", message: "You already added this user");return }
                        LocalData.shared.users.append(user)
                        LocalData.shared.saveUsers()
                        let nameOfParent = self.presentingViewController?.title
                        switch nameOfParent {
                        case "wallet":
                            DispatchQueue.main.async {
                                self.dismiss(animated: true, completion: nil)
                            }
                        default: self.proceed()
                        }
                    case true: self.addAller(title: "Error!", message: "This username is in user")
                    }
                }
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
    
    
    @objc func dismissKeyboard() {
        textField.textField.endEditing(true)
        keyTextField.textField.endEditing(true)
    }
    
    func createTap() -> UITapGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        
        return tap
    }
}
//MARK: - textfield delegate
extension ManualAddAccount: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
    
}
