//
//  File.swift
//  List
//
//  Created by Амир Гезаль on 24.02.2020.
//  Copyright © 2020 Амир Гезаль. All rights reserved.
//

import Foundation
import EosioSwift
import EosioSwiftAbieosSerializationProvider
import EosioSwiftSoftkeySignatureProvider
import EosioSwiftEcc

private enum RequestMethod: String {
    case GET = "GET"
    case POST = "POST"
}

private enum Postfix: String {
    case getBalance = "get_currency_balance"
}

private enum CurrenciesRequest: String {
    case EOS = "eosio.token"
    case JNG = "JUNGLE"
}

class NetworkManager {
    
    static let shared = NetworkManager()
    //private let node = "https://eos.test.list.family/v1/chain/"
    private let node = "https://jungle2.cryptolions.io:443/v1/chain/"
    
    func isUsernameAndPasswordValid(with username: String, password: String) -> Bool {
        
        guard Validations.isUserNameFormatValid(username) else { return false }
        //guard Validations.isPasswordRormatValid(password) else { return false }
        
        return true
    }
    
    func isUsernameFree(username: String, closure: @escaping (Result<Bool,Errors>)->Void) {
        let requestDict: [String : Any] = ["code" : CurrenciesRequest.EOS.rawValue, "account" : username]
        let requestBody = try? JSONSerialization.data(withJSONObject: requestDict)
        
        guard let url = URL(string: node + Postfix.getBalance.rawValue) else { return }
        var request = URLRequest(url: url)
        request.httpBody = requestBody
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else { return }
            guard let Response = response as? HTTPURLResponse, Response.statusCode < 300 else { return }
            
            guard let dataBack = data else { return }
            let stringData = String(bytes: dataBack, encoding: .utf8)!
            guard stringData == "[]" else { closure(.failure(.usernameIsNotValid)); return }
            closure(.success(true))
        }
        task.resume()
    }
    
    func registerAccount(username: String, publicKey: String, closure: @escaping (Result<Bool,Errors>)->Void) {
        let requestDict: [String : Any] = ["username" : username, "publicKey" : publicKey]
        let requestBody = try? JSONSerialization.data(withJSONObject: requestDict, options: .sortedKeys)
        
        guard let url = URL(string: "https://wallet.dev.list.family/users/create/") else { closure(.failure(.url));return }
        var request = URLRequest(url: url)
        request.httpBody = requestBody!
        request.setValue("\(requestBody!.count)", forHTTPHeaderField: "Content-Length")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil else { closure(.failure(.error)); return }
            guard let Response = response as? HTTPURLResponse, Response.statusCode == 200 else { closure(.failure(.response));return }
            closure(.success(true))
            
        }
        
        task.resume()
    }
    
    func addAccount(_ username: String, closure: @escaping (Result<(Bool,UserData?),Errors>) -> Void) {
        
        let requestDict: [String : Any] = ["code" : CurrenciesRequest.EOS.rawValue, "account" : username]
        let requestBody = try? JSONSerialization.data(withJSONObject: requestDict)
        
        guard let url = URL(string: node + Postfix.getBalance.rawValue) else { closure(.failure(.url)); return }
        var request = URLRequest(url: url)
        request.httpBody = requestBody
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else { closure(.failure(.error)); return }
            guard let Response = response as? HTTPURLResponse, Response.statusCode < 300 else { closure(.failure(.response)); return }
            guard let dataBack = data else { closure(.failure(.data)); return }
            var stringBack = String(bytes: dataBack, encoding: .utf8)!
            guard stringBack != "[]" else { closure(.success((true, nil))); return }
            stringBack.removeAll { (char) -> Bool in
                char == "[" || char == "]" || char == "\""
            }
            let currenciesBalances = stringBack.components(separatedBy: ",")
            let eos = currenciesBalances[0]
            let eosBalance = eos.components(separatedBy: " ")[0]
            let jungle = currenciesBalances[1]
            let jungleBalance = jungle.components(separatedBy: " ")[0]
            closure(.success((false, UserData(username: username, eos: Double(eosBalance) ?? 0, jungle: Double(jungleBalance) ?? 0))))
        }
        task.resume()
    }
    
    func getBalance() {
        let requestDict: [String:Any] = ["code":CurrenciesRequest.EOS.rawValue, "account": UserInfo.shared.username]
        let requestBody = try? JSONSerialization.data(withJSONObject: requestDict)
        let url = URL(string: node + Postfix.getBalance.rawValue)!
        var request = URLRequest(url: url)
        request.httpBody = requestBody
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else { return }
            guard let dataBack = data else { return  }
            var stringBack = String(bytes: dataBack, encoding: .utf8)!
            if stringBack != "[]" {
                stringBack.removeAll { (char) -> Bool in
                    char == "[" || char == "]" || char == "\""
                }
                let currenciesBalances = stringBack.components(separatedBy: ",")
                if currenciesBalances.count == 2 {
                    let eos = currenciesBalances[0]
                    let eosBalance = eos.components(separatedBy: " ")[0]
                    let jungle = currenciesBalances[1]
                    let jungleBalance = jungle.components(separatedBy: " ")[0]
                    UserInfo.shared.EOSBalance = Double(eosBalance)!
                    UserInfo.shared.JUNGLEBalance = Double(jungleBalance)!
                } else {
                    let currency = currenciesBalances[0].components(separatedBy: " ")[1]
                    switch currency {
                    case "JNGLE":
                        UserInfo.shared.JUNGLEBalance = Double(currenciesBalances[0].components(separatedBy: " ")[0])!
                        UserInfo.shared.EOSBalance = 0
                    default:
                        UserInfo.shared.JUNGLEBalance = 0
                        UserInfo.shared.EOSBalance = Double(currenciesBalances[0].components(separatedBy: " ")[0])!
                    }
                }
            } else {
                UserInfo.shared.EOSBalance = 0
                UserInfo.shared.JUNGLEBalance = 0
            }
        }
        task.resume()
    }
    
    func getBalanceAndSaveUser(for user: String,privateKey: String, closure: @escaping (Result<User,Errors>)->Void) {
        let requestDict: [String:Any] = ["code":CurrenciesRequest.EOS.rawValue, "account": user]
        let requestBody = try? JSONSerialization.data(withJSONObject: requestDict)
        let url = URL(string: node + Postfix.getBalance.rawValue)!
        var request = URLRequest(url: url)
        request.httpBody = requestBody
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else { print(1);return }
            
            let user = User(userName: user, privateKey: privateKey)
            LocalData.shared.users.append(user)
            LocalData.shared.saveUsers()
            UserInfo.shared.username = user.userName
            UserInfo.shared.EOSBalance = 0.0
            UserInfo.shared.JUNGLEBalance = 0.0
            closure(.success(user))
        }
        task.resume()
    }
    
    func reloadUser(closure: @escaping (Result<Bool,Errors>)->Void) {
        
        let requestDict: [String:Any] = ["code":CurrenciesRequest.EOS.rawValue, "account": UserInfo.shared.username]
        let requestBody = try? JSONSerialization.data(withJSONObject: requestDict)
        let url = URL(string: node + Postfix.getBalance.rawValue)!
        var request = URLRequest(url: url)
        request.httpBody = requestBody
        request.httpMethod = "POST"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else { return }
            guard let dataBack = data else { return  }
            var stringBack = String(bytes: dataBack, encoding: .utf8)!
            if stringBack != "[]" {
                stringBack.removeAll { (char) -> Bool in
                    char == "[" || char == "]" || char == "\""
                }
                let currenciesBalances = stringBack.components(separatedBy: ",")
                if currenciesBalances.count == 2 {
                    let eos = currenciesBalances[0]
                    let eosBalance = eos.components(separatedBy: " ")[0]
                    let jungle = currenciesBalances[1]
                    let jungleBalance = jungle.components(separatedBy: " ")[0]
                    UserInfo.shared.EOSBalance = Double(eosBalance)!
                    UserInfo.shared.JUNGLEBalance = Double(jungleBalance)!
                } else {
                    let currency = currenciesBalances[0].components(separatedBy: " ")[1]
                    switch currency {
                    case "JNGLE":
                        UserInfo.shared.JUNGLEBalance = Double(currenciesBalances[0].components(separatedBy: " ")[0])!
                        UserInfo.shared.EOSBalance = 0
                    default:
                        UserInfo.shared.JUNGLEBalance = 0
                        UserInfo.shared.EOSBalance = Double(currenciesBalances[0].components(separatedBy: " ")[0])!
                    }
                }
            } else {
                UserInfo.shared.EOSBalance = 0
                UserInfo.shared.JUNGLEBalance = 0
            }
            closure(.success(true))
        }
        task.resume()
    }
}
extension NetworkManager {
    
    fileprivate func request(method: RequestMethod, dict: [String:Any], url: String, closure: @escaping (Result<Bool,Errors>)->Void) {
        
        guard let url = URL(string: url) else { closure(.failure(.url)); return }
        
        var request = URLRequest(url: url)
        let requestBody = try? JSONSerialization.data(withJSONObject: dict)
        request.httpBody = requestBody
        request.httpMethod = method.rawValue
        
        let task = URLSession.shared.dataTask(with: request) { (data, respose, error) in
            
        }
        task.resume()
    }
    
}
