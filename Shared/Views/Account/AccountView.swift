//
//  AccountView.swift
//  Exbook
//
//  Created by Adrian Stypinski on 18/07/2022.
//

import SwiftUI

struct AccountView: View {
    var body: some View {
        MainView {
            Text("Account View")
        }
        .onShake {
            print("ELO")
        }
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
