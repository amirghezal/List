//
//  QRView.swift
//  List
//
//  Created by Амир Гезаль on 21.02.2020.
//  Copyright © 2020 Амир Гезаль. All rights reserved.
//

import UIKit

class QRView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .clear
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.white.cgColor
    }
    
}
