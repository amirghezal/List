//
//  CustomVC.swift
//  List
//
//  Created by Амир Гезаль on 20.02.2020.
//  Copyright © 2020 Амир Гезаль. All rights reserved.
//

import UIKit

class ListVC: UIViewController{
    
    
    let vcBottomButton = ListButton(title: "")
    let textField = ListTextField("")
    //let tap = UITapGestureRecognizer(target: self, action: #selector(UIView.endEditing(_:)))
    
    let vcName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        
        return label
    }()
    
    let contentView: UIView = {
        let content = UIView()
        content.translatesAutoresizingMaskIntoConstraints = false
        
        return content
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupLayouts()
        //view.addGestureRecognizer(tap)
    }
    
    
    
    private func setupLayouts() {
        view.addSubview(contentView)
        contentView.addSubview(vcName)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            contentView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            
            vcName.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            vcName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            vcName.widthAnchor.constraint(equalTo: contentView.widthAnchor)
        ])
    }
    
    func addBottomButton(_ title: String) {
        contentView.addSubview(vcBottomButton)
        vcBottomButton.setTitle(title, for: .normal)
        NSLayoutConstraint.activate([
            vcBottomButton.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            vcBottomButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -30),
            vcBottomButton.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            vcBottomButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    func addTopTextField(_ title: String) {
        contentView.addSubview(textField)
        textField.label.text = title
        NSLayoutConstraint.activate([
            textField.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            textField.heightAnchor.constraint(equalToConstant: 45),
            textField.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            textField.topAnchor.constraint(equalTo: self.vcName.bottomAnchor, constant: 60)
        ])
    }
    func addAller(title: String, message: String)  {
        DispatchQueue.main.async {
            let allerVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let allerdtAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            allerVC.addAction(allerdtAction)
            self.present(allerVC, animated: true)
        }
    }
    func addAllertWithCLosure(title: String, message: String, closure: @escaping ((UIAlertAction)->Void)) {
        DispatchQueue.main.async {
            let allerVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let allerdtAction = UIAlertAction(title: "OK", style: .cancel, handler: closure)
            allerVC.addAction(allerdtAction)
            self.present(allerVC, animated: true)
        }
    }
    
   
    
   
}
