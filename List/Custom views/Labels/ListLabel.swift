//
//  ListLabel.swift
//  List
//
//  Created by Амир Гезаль on 24.02.2020.
//  Copyright © 2020 Амир Гезаль. All rights reserved.
//

import UIKit

public class ListLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(ofSize size: CGFloat, ofWeight weight: UIFont.Weight,ofColor color: UIColor, _ text: String) {
        super.init(frame: .zero)
        self.numberOfLines = 0
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textColor = color
        self.font = UIFont.systemFont(ofSize: size, weight: weight)
        self.text = text
    }
}
