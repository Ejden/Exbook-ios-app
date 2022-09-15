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
                .background(StandardUI.Color.background)
                .environmentObject(appEnvironment.container)
        }
    }
}
