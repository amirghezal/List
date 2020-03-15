//
//  Transaction.swift
//  List
//
//  Created by Амир Гезаль on 02.03.2020.
//  Copyright © 2020 Амир Гезаль. All rights reserved.
//

import Foundation

struct Transaction: Codable {
    var reciever: String
    var amount: String
    var currency: String
}
