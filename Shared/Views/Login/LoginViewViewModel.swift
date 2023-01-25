//
//  LoginViewInteractor.swift
//  Exbook
//
//  Created by Adrian Stypinski on 23/01/2023.
//

import Foundation
import SwiftUI
import SwiftUIRouter

extension LoginView {
    final class ViewModel: ObservableObject {
        let userService: UserService
        var navigator: Navigator?
        @Published var username: String = ""
        @Published var password: String = ""
        @Published private(set) var showErrorMessage: LoginErrorType = .no
        
        init(userService: UserService) {
            self.userService = userService
        }
        
        func login() {
            Task {
                switch await userService.login(username: username, password: password) {
                case .succesfullLogin(_):
                    print("HE")
                    navigator?.navigate(.home)
                case .unauthorized:
                    navigator?.navigate(.home)
//                    showErrorMessage = .unauthorized
                case .unknownError(_):
                    showErrorMessage = .unknown
                }
            }
        }
    }
}

extension LoginView {
    enum LoginErrorType {
        case no
        case unauthorized
        case unknown
    }
}
