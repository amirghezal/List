//
//  Users.swift
//  List
//
//  Created by Амир Гезаль on 02.03.2020.
//  Copyright © 2020 Амир Гезаль. All rights reserved.
//

import UIKit

class UsersVC: ListVC, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return LocalData.shared.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserCell
        cell.username.text = LocalData.shared.users[indexPath.row].userName
        cell.balance.text = LocalData.shared.users[indexPath.row].privateKey
        
        return cell
    }
    
    lazy var tableView = UITableView(frame: .zero, style: .grouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(UserCell.self, forCellReuseIdentifier: "UserCell")
        self.vcName.text = "You accounts"
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBackground
        configure()
        addGestures()
    }
    
    
    func configure() {
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 63
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.vcName.bottomAnchor),
            tableView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 600),
            tableView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let vc = presentingViewController as! WalletViewController
        vc.usernameLabel.text = UserInfo.shared.username
        vc.vcName.text = UserInfo.shared.currentBalance
    }
    
}

extension UsersVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UserInfo.shared.username = LocalData.shared.users[indexPath.row].userName
        UserInfo.shared.privateKey = LocalData.shared.users[indexPath.row].privateKey
        NetworkManager.shared.reloadUser { result in
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self.handleRightSwipe()
                }
            default: break
            }
        }
    }
}

extension UsersVC {
    private func addGestures() {
        self.view.addGestureRecognizer(createRightSwipeGestire())
    }
    
    private func createRightSwipeGestire() -> UISwipeGestureRecognizer {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(handleRightSwipe))
        swipe.direction = .right
        return swipe
    }
    
    @objc private func handleRightSwipe() {
        let transition: CATransition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = CATransitionType.reveal
        transition.subtype = CATransitionSubtype.fromLeft
        self.view.window!.layer.add(transition, forKey: nil)
        self.dismiss(animated: false, completion: nil)
    }
}
