//
//  ListErrors.swift
//  List
//
//  Created by Амир Гезаль on 24.02.2020.
//  Copyright © 2020 Амир Гезаль. All rights reserved.
//

import Foundation


enum Errors: String, Error {
    case url = "url"
    case error = "Check you internet conection 📲"
    case response = "Server is curently broken 😔"
    case data = "Something went wrong 😔"
    case wrongUsername = "Entered username is not valid. Please try another 👻"
    case wrongPassword = "Entered password is not valid. Please try another"
    case usernameIsNotValid = "This username is in use. Please try another 👻"
}

