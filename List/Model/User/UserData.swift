//
//  User.swift
//  List
//
//  Created by Амир Гезаль on 24.02.2020.
//  Copyright © 2020 Амир Гезаль. All rights reserved.
//

import UIKit

class UserData: Codable {
    var userName: String
    var EOSBalance: Double
    var JUNGLEBalance: Double
    
    init(username: String,eos: Double,jungle: Double) {
        userName = username
        EOSBalance = eos
        JUNGLEBalance = jungle
        UserInfo.shared.username = username
        UserInfo.shared.choosedCurrency = Currencies.EOS.rawValue
        UserInfo.shared.EOSBalance = eos
        UserInfo.shared.JUNGLEBalance = jungle
        UserInfo.shared.isLoggedIn = true
    }
}

