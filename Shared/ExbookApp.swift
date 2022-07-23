//
//  ExbookApp.swift
//  Shared
//
//  Created by Adrian Stypinski on 18/07/2022.
//

import SwiftUI

@main
struct ExbookApp: App {
    let appEnvironment = AppEnvironment.create()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appEnvironment.container)
        }
    }
}
