//
//  Model.swift
//  Exbook
//
//  Created by Adrian Stypinski on 18/07/2022.
//

import Foundation

class AppState {
    let userState: UserState = UserState()
}

class UserState {
    private(set) var isLoggedIn: Bool = false
    private(set) var token: UserToken? = nil
    
    func logInUser(userToken: UserToken) {
        self.token = userToken
        self.isLoggedIn = true
    }
    
    func logoutUser() {
        self.token = nil
        self.isLoggedIn = false
    }
}
