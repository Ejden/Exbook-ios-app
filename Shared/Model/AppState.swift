//
//  Model.swift
//  Exbook
//
//  Created by Adrian Stypinski on 18/07/2022.
//

import Foundation

struct AppState {
    let userData: UserData = UserData()
}

struct UserData {
    var isLoggedIn: Bool = false
}
