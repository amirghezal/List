import Foundation

public class UserInfo {
    
    static let shared = UserInfo()
    
    private let defaults = UserDefaults.standard
    
    var username: String {
        get {
            return defaults.value(forKey: "username") as! String
        }
        set {
            defaults.set(newValue, forKey: "username")
        }
    }
    
    var choosedCurrency: String {
        get {
            defaults.value(forKey: "choosedCurrency") as! String
        }
        set {
            defaults.set(newValue, forKey: "choosedCurrency")
        }
    }
    
    var EOSBalance: Double {
        get {
            defaults.double(forKey: "eosBalance")
        }
        set {
            defaults.set(newValue, forKey: "eosBalance")
        }
    }
    
    var JUNGLEBalance: Double {
        get {
            defaults.double(forKey: "jungleBalance")
        }
        set {
            defaults.set(newValue, forKey: "jungleBalance")
        }
    }
    
    var isLoggedIn: Bool {
        get {
            return defaults.bool(forKey: "isLoggedIn")
        }
        set {
            defaults.set(newValue, forKey: "isLoggedIn")
        }
    }
    
    var publicKey: String {
        get {
            return defaults.value(forKey: "publicKey") as! String
        }
        set {
            defaults.set(newValue, forKey: "publicKey")
        }
    }
    
    var privateKey: String {
        get {
            return defaults.value(forKey: "privateKey") as! String
        }
        set {
            defaults.set(newValue, forKey: "privateKey")
        }
    }
    
    private func getBalance() -> Double {
        switch choosedCurrency {
        case Currencies.EOS.rawValue:
            return UserInfo.shared.EOSBalance
        case Currencies.JNG.rawValue:
            return UserInfo.shared.JUNGLEBalance
        default:
            return 0
        }
    }
    
    var currentBalance: String {
        get {
            return String(format: "%.4f", getBalance()) + " " + choosedCurrency
        }
    }
}
