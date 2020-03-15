//
//  LocalDaat.swift
//  List
//
//  Created by Амир Гезаль on 02.03.2020.
//  Copyright © 2020 Амир Гезаль. All rights reserved.
//

import Foundation

class LocalData {
    
    static let shared = LocalData()
    
    var transactions = [Transaction]()
    var users        = [User]()
    
    let dataFilePath = FileManager.default
        .urls(for: .documentDirectory,in: .userDomainMask)
        .first?
        .appendingPathComponent("Items.plist")
    
    let secondDataFilePath = FileManager.default
        .urls(for: .documentDirectory, in: .userDomainMask)
        .first?
        .appendingPathComponent("Users.plist")
    
    func saveTransaction() {
        let endoder = PropertyListEncoder()
        do {
            let data = try endoder.encode(transactions)
            try data.write(to: dataFilePath!)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadTransactions() -> [Transaction] {
        var array = [Transaction]()
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                array = try decoder.decode([Transaction].self, from: data)
            } catch {
                print(error.localizedDescription)
            }
        }
        return array
    }
    
    func saveUsers() {
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(users)
            try data.write(to: secondDataFilePath!)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadUsers() -> [User] {
        var array = [User]()
        if let data = try? Data(contentsOf: secondDataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
                array = try decoder.decode([User].self, from: data)
            } catch {
                print(error.localizedDescription)
            }
        }
        return array
    }
    
}
