//
//  WalletViewController.swift
//  List
//
//  Created by Амир Гезаль on 20.02.2020.
//  Copyright © 2020 Амир Гезаль. All rights reserved.
//

import UIKit

class WalletViewController: ListVC {
    
    var transactionsReversed = LocalData.shared.loadTransactions()
    lazy var transactions = [Transaction]()
    var username: String = UserInfo.shared.username
    var balance : String = UserInfo.shared.currentBalance
    let usernameLabel = ListLabel(ofSize: 20, ofWeight: .light, ofColor: .label, UserInfo.shared.username)
    
    lazy var tableView = UITableView(frame: .zero, style: .grouped)
    
    private lazy var topViewCollection = WalletTopView()
    private lazy var Wallets = WalletButton(nil, "Wallets")
    private lazy var send = WalletButton(nil, "Send")
    private lazy var add = WalletButton(nil, "Add")
    private lazy var swap = WalletButton(nil, "Swap")
    private lazy var history = ListLabel(ofSize: 30, ofWeight: .regular, ofColor: .secondaryLabel, "History")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.shared.getBalance()
        setupSelf()
        setupTableView()
        self.vcName.text = balance
        self.tableView.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
        handleCurrencyChange()
        handleCurrencyChange()
    }
    
    func setupSelf() {
        self.title = "wallet"
        addSubviews()
        setupLayouts()
        addActions()
        transactions = transactionsReversed.reversed()
    }
}

//MARK: - DataSource
extension WalletViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WalletCell", for: indexPath) as! WalletCell
        cell.typeLabel.text = transactions[indexPath.row].reciever
        cell.amountLabel.text = transactions[indexPath.row].amount + " " + transactions[indexPath.row].currency
        
        return cell
    }
}



//MARK: - SubViews managment
private extension WalletViewController {
    
    func addSubviews() {
        contentView.addSubview(topViewCollection)
        contentView.addSubview(tableView)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(Wallets)
        contentView.addSubview(send)
        contentView.addSubview(add)
        contentView.addSubview(swap)
        contentView.addSubview(history)
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.rowHeight = 60
        tableView.register(WalletCell.self, forCellReuseIdentifier: "WalletCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .clear
    }
    
    func setupLayouts() {
        let width = view.frame.width - 80
        let padding : CGFloat = 20
        let widthOfButton : CGFloat = 60
        let space : CGFloat = (width - (widthOfButton * 4) - (padding * 2))/2
        
        NSLayoutConstraint.activate([
            topViewCollection.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            topViewCollection.topAnchor.constraint(equalTo: contentView.topAnchor),
            topViewCollection.widthAnchor.constraint(equalToConstant: 100),
            
            usernameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            usernameLabel.topAnchor.constraint(equalTo: vcName.bottomAnchor, constant: 8),
            usernameLabel.heightAnchor.constraint(equalToConstant: 25),
            
            Wallets.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            Wallets.heightAnchor.constraint(equalToConstant: 60),
            Wallets.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 40),
            Wallets.widthAnchor.constraint(equalToConstant: widthOfButton),
            
            send.leadingAnchor.constraint(equalTo: Wallets.trailingAnchor, constant: space),
            send.heightAnchor.constraint(equalToConstant: 60),
            send.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 40),
            send.widthAnchor.constraint(equalToConstant: widthOfButton),
            
            add.leadingAnchor.constraint(equalTo: send.trailingAnchor, constant: space),
            add.heightAnchor.constraint(equalToConstant: 60),
            add.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 40),
            add.widthAnchor.constraint(equalToConstant: widthOfButton),
            
            swap.leadingAnchor.constraint(equalTo: add.trailingAnchor, constant: space),
            swap.heightAnchor.constraint(equalToConstant: 60),
            swap.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 40),
            swap.widthAnchor.constraint(equalToConstant: widthOfButton),
            
            history.topAnchor.constraint(equalTo: Wallets.bottomAnchor, constant: 30),
            history.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            history.heightAnchor.constraint(equalToConstant: 30),
            
            tableView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            tableView.topAnchor.constraint(equalTo: history.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
}

//MARK: - actions
private extension WalletViewController {
    
    func addActions() {
        Wallets.addTarget(self, action: #selector(handleWallets), for: .touchUpInside)
        send.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        add.addTarget(self, action: #selector(handleAdd), for: .touchUpInside)
        swap.addTarget(self, action: #selector(handleCurrencyChange), for: .touchUpInside)
        addGestures()
    }
    
    @objc func handleWallets() {
        present(UsersVC(), animated: true)
    }
    
    @objc func handleSend() {
        present(SendViewController(), animated: true)
    }
    
    @objc func handleAdd() {
        present(ManualAddAccount(), animated: true)
    }
    
    func addGestures() {
        self.view.addGestureRecognizer(createRightSwipeGestire())
        self.view.addGestureRecognizer(createDownSwipe())
    }
    
    func createRightSwipeGestire() -> UISwipeGestureRecognizer {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeLeft))
        swipe.direction = .left
        return swipe
    }
    
    func createDownSwipe() -> UISwipeGestureRecognizer {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeDown))
        swipe.direction = .down
        return swipe
    }
    
    @objc func handleSwipeLeft() {
        let vc = UsersVC()
        vc.modalPresentationStyle = .fullScreen
        let transition: CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromRight
        self.view.window!.layer.add(transition, forKey: nil)
        show(vc, sender: false)
    }
    
    @objc func handleSwipeDown() {
        dismiss(animated: true)
    } 
    
    @objc func handleCurrencyChange() {
        switch UserInfo.shared.choosedCurrency {
        case Currencies.EOS.rawValue:
            UserInfo.shared.choosedCurrency = Currencies.JNG.rawValue
        case Currencies.JNG.rawValue:
            UserInfo.shared.choosedCurrency = Currencies.EOS.rawValue
        default: break
        }
        self.balance = UserInfo.shared.currentBalance
        self.vcName.text = balance
    }
}
