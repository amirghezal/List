//
//  SendViewController.swift
//  List
//
//  Created by Амир Гезаль on 21.02.2020.
//  Copyright © 2020 Амир Гезаль. All rights reserved.
//

import UIKit

class SendViewController: ListVC {

    private lazy var middleTextField = ListTextField("Send to")
    private lazy var bottomTextField = ListTextField("Memo")
    private lazy var balbance = ListLabel(ofSize: 15, ofWeight: .thin, ofColor: .label, UserInfo.shared.currentBalance)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSelf()
        setupLayouts()
        addActions()
        self.textField.textField.delegate = self
        middleTextField.textField.delegate = self
        bottomTextField.textField.delegate = self
        print(UserInfo.shared.username)
        print(UserInfo.shared.privateKey)
    }
    
    func setupSelf() {
        vcName.text = "Send"
        addBottomButton("Send")
        addTopTextField("Amount")
        textField.textField.placeholder = "Enter amount"
        bottomTextField.textField.placeholder = "Enter memo"
        
    }
    
    
    func setupLayouts() {
        
        contentView.addSubview(balbance)
        contentView.addSubview(middleTextField)
        contentView.addSubview(bottomTextField)
        
        NSLayoutConstraint.activate([
            balbance.topAnchor.constraint(equalTo: self.textField.bottomAnchor, constant: 10),
            balbance.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            balbance.heightAnchor.constraint(equalToConstant: 15),
            
            middleTextField.topAnchor.constraint(equalTo: self.textField.bottomAnchor, constant: 80),
            middleTextField.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            middleTextField.heightAnchor.constraint(equalToConstant: 45),
            
            bottomTextField.topAnchor.constraint(equalTo: middleTextField.bottomAnchor, constant: 20),
            bottomTextField.heightAnchor.constraint(equalToConstant: 45),
            bottomTextField.widthAnchor.constraint(equalTo: contentView.widthAnchor)
        ])
    }
    
    func addActions() {
        vcBottomButton.addTarget(self, action: #selector(send), for: .touchUpInside)
    }
    
    @objc private func send() {
        guard let amountText = textField.textField.text, amountText != "" else { return }
        guard let reciever = middleTextField.textField.text?.lowercased(), reciever != "" else { return }
        guard let memo = bottomTextField.textField.text else { return }

        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 4
        formatter.maximumFractionDigits = 4

        guard let amountDouble = Double(amountText), amountDouble != 0 else { return }

        let number = formatter.string(from: NSNumber(value: amountDouble))
        guard let amount = number else { return }
        
        TransactionManager.shared.send(quantity: amount, to: reciever, memo: memo) { result in
            switch result {
            case .success(let id):
                let transaction = Transaction(reciever: reciever, amount: amount, currency: UserInfo.shared.choosedCurrency)//Transaction(reciever: reciever, amount: amount)
                LocalData.shared.transactions.append(transaction)
                LocalData.shared.saveTransaction()
                DispatchQueue.main.async {
                    let vc = SuccesViewController()
                    vc.transactionID = id
                    vc.username = reciever
                    self.present(vc, animated: true, completion: nil)
                }
            case .failure(_):
                DispatchQueue.main.async {
                    self.present(self.addAller(), animated: true, completion: nil)
                }
            }
        }
            
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let vc = presentingViewController as! WalletViewController
        NetworkManager.shared.getBalance()
        DispatchQueue.main.async {
            vc.transactions = LocalData.shared.transactions
            vc.balance = UserInfo.shared.currentBalance
            vc.vcName.text = vc.balance
            vc.tableView.reloadData()
        }
    }
}
extension SendViewController: UITextFieldDelegate {
    func addAller() -> UIAlertController {
        let allerVC = UIAlertController(title: "Error!", message: "The operation couldn't be compleete", preferredStyle: .alert)
        let allerdtAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        allerVC.addAction(allerdtAction)
        return allerVC
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == bottomTextField.textField {
            send()
        } else {
            textField.endEditing(true)
        }
        return true
    }
   
}
