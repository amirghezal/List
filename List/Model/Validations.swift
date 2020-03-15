//
//  Validations.swift
//  List
//
//  Created by Амир Гезаль on 25.02.2020.
//  Copyright © 2020 Амир Гезаль. All rights reserved.
//

import Foundation

struct Validations {
    
    static func isUserNameFormatValid(_ value: String) -> Bool {
        do {
            if try NSRegularExpression(pattern: "^([a-z1-5.]{1,11}[a-z1-5]$)|(^[a-z1-5.]{12}[a-j1-5])$", options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                return false
            }
        } catch {
            return false
        }
        return true
    }
    static func isPasswordRormatValid(_ value: String) -> Bool {
            do {
                if try NSRegularExpression(pattern: "^[A-Z0-9a-z._%+-]$", options: .caseInsensitive).firstMatch(in: value, options: [], range: NSRange(location: 0, length: value.count)) == nil {
                    return false
                }
            } catch {
                return false
            }
            return true
        }
}
