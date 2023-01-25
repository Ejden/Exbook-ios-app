//
//  LoginView.swift
//  Exbook
//
//  Created by Adrian Stypinski on 24/09/2022.
//

import SwiftUI
import SwiftUIRouter

struct LoginView: View {
    @EnvironmentObject var navigator: Navigator
    @StateObject var vm: ViewModel
    
    init(userService: UserService) {
        _vm = StateObject(wrappedValue: ViewModel(userService: userService))
    }
    
    var body: some View {
        MainView {
            VStack(alignment: .leading, spacing: StandardUI.Spacing.regular) {
                HStack {
                    Spacer()
                        Text("Log in")
                            .font(.largeTitle)
                    Spacer()
                }
                HStack {
                    Image(systemName: "person")
                    TextField(text: $vm.username) {
                        Text("Login")
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                HStack {
                    Image(systemName: "lock")
                    TextField(text: $vm.password) {
                        Text("Hasło")
                    }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                StandardButton(type: .primary, text: "Zaloguj") {
                    vm.login()
                }
                HStack {
                    switch vm.showErrorMessage {
                    case .unauthorized:
                        errorMessage(message: "Wrong login or password")
                    case .unknown:
                        errorMessage(message: "Unknown error occurred")
                    case .no:
                        EmptyView()
                    }
                }
            }
            .padding()
        }
        .background(StandardUI.Color.desk)
    }
}

extension LoginView {
    func errorMessage(message: String) -> some View {
        Group {
            Spacer()
            Text(message)
                .foregroundColor(StandardUI.Color.errorRed)
            Spacer()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(userService: MockUserService())
            .environmentObject(Navigator.initWith(initialPath: .account))
            .environmentObject(DIContainer.mock)
    }
}
