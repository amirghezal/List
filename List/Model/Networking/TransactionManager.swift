//
//  TransactionManager.swift
//  List
//
//  Created by Амир Гезаль on 28.02.2020.
//  Copyright © 2020 Амир Гезаль. All rights reserved.
//

import Foundation
import EosioSwift
import EosioSwiftAbieosSerializationProvider
import EosioSwiftSoftkeySignatureProvider
import EosioSwiftEcc

class TransactionManager {
    
    private struct TransferActionData: Codable {
        var from: EosioName
        var to: EosioName
        var quantity: String
        var memo: String
    }
    private var rpcProvider: EosioRpcProvider?
    private var transactionFactory: EosioTransactionFactory?
    private let endpoint = URL(string: "https://jungle2.cryptolions.io:443")!
    private let permission = "active"
    
    static let shared = TransactionManager()
    
    var privateKeys = [UserInfo.shared.privateKey]
    
    func send(quantity: String, to: String, memo: String, closure: @escaping (Result<String,Errors>)-> Void) {
        
        do {
            
            let amount = quantity + " " + (UserInfo.shared.choosedCurrency == "JNG" ? "JUNGLE" : "EOS")
            let sender = try EosioName(UserInfo.shared.username)
            let reciever = try EosioName(to)
            
            rpcProvider = EosioRpcProvider(endpoint: endpoint)
            guard let rpcProvider = rpcProvider else {
                print("ERROR: No RPC provider found.")
                return
            }
            let serializationProvider = EosioAbieosSerializationProvider()
            let signatureProvider = try! EosioSoftkeySignatureProvider(privateKeys: privateKeys)
            transactionFactory = EosioTransactionFactory(
                rpcProvider: rpcProvider,
                signatureProvider: signatureProvider,
                serializationProvider: serializationProvider
            )
            guard let transactionFactory = transactionFactory else {
                print("ERROR: No transaction factory found.")
                return
            }
            let transaction = transactionFactory.newTransaction()
            
            print(sender,reciever,amount,memo)
            let action = try! EosioTransaction.Action(
                account: EosioName("eosio.token"),
                name: EosioName("transfer"),
                authorization: [EosioTransaction.Action.Authorization(
                    actor: sender,
                    permission: EosioName("active")
                    )],
                data: TransferActionData(
                    from: sender,
                    to: reciever,
                    quantity: amount,
                    memo: memo
                )
            )
            
            transaction.add(action: action)
            
            transaction.signAndBroadcast { result in
                
                //print(try! transaction.toJson(prettyPrinted: true))
                
                switch result {
                case .failure (let error):
                    DispatchQueue.main.async {
                        print(error.eosioError.description)
                    }
                    print("ERROR SIGNING OR BROADCASTING TRANSACTION")
                    print(error)
                    print(error.reason)
                    closure(.failure(.error))
                case .success:
                    if let transactionId = transaction.transactionId {
                        DispatchQueue.main.async {
                            UserInfo.shared.EOSBalance -= Double(quantity)!
                            closure(.success(transactionId))
                        }
                        
                    }
                }
            }
        } catch {
            print(error.eosioError.description)
        }
        
    }
    
}
