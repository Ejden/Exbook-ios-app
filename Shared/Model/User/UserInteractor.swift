//
//  UserInteractor.swift
//  Exbook
//
//  Created by Adrian Stypinski on 24/09/2022.
//

import Foundation

protocol UserService {
    func login(username: String, password: String) async -> LoginStatus
}

final class RealUserService: UserService {
    private let userClient: UserClient
    private let appState: AppState
    
    init(userClient: UserClient, appState: AppState) {
        self.userClient = userClient
        self.appState = appState
    }
    
    func login(username: String, password: String) async -> LoginStatus {
        let result = await userClient.login(username: username, password: password)
        switch result {
        case .succesfullLogin(let token):
            appState.userState.logInUser(userToken: token)
        default:
            appState.userState.logoutUser()
        }
        return result
    }
}

final class MockUserService: UserService {
    func login(username: String, password: String) async -> LoginStatus {
        return .unauthorized
    }
}
