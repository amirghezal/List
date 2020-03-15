//
//  AllTokensVC.swift
//  List
//
//  Created by Амир Гезаль on 24.02.2020.
//  Copyright © 2020 Амир Гезаль. All rights reserved.
//

import UIKit

class AllTokensVC: ListVC {
    
    private let EOSLabel = ListTokenLabel(Currencies.EOS.rawValue)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSelf()
    }
    
    func setupSelf() {
        self.vcName.text = "All tokens"
        configureLayouts()
        addGestures()
        setupLabelTap()
    }
    
    private func configureLayouts() {
        self.contentView.addSubview(EOSLabel)
        
        NSLayoutConstraint.activate([
            EOSLabel.topAnchor.constraint(equalTo: vcName.bottomAnchor, constant: 70),
            EOSLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            EOSLabel.heightAnchor.constraint(equalToConstant: 45),
            
        ])
    }
    
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
    
    
    @objc func labelTapped(_ sender: UITapGestureRecognizer) {
        
        switch UserInfo.shared.choosedCurrency {
        case Currencies.EOS.rawValue: UserInfo.shared.choosedCurrency = Currencies.JNG.rawValue
        case Currencies.JNG.rawValue: UserInfo.shared.choosedCurrency = Currencies.EOS.rawValue
        default: break
        }
        handleRightSwipe()
    }
    
    func setupLabelTap() {
        
//        let labelTapJNG = UITapGestureRecognizer(target: self, action: #selector(self.labelTapped(_:)))
//        self.JNGLabel.isUserInteractionEnabled = true
//        self.JNGLabel.addGestureRecognizer(labelTapJNG)
        
        let labelTapEOS = UITapGestureRecognizer(target: self, action: #selector(self.labelTapped(_:)))
        self.EOSLabel.isUserInteractionEnabled = true
        self.EOSLabel.addGestureRecognizer(labelTapEOS)
    }
    
}
