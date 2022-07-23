//
//  ExbookApp.swift
//  Shared
//
//  Created by Adrian Stypinski on 18/07/2022.
//

import SwiftUI

@main
struct ExbookApp: App {
    let dependencyInjectorContainer = DIContainer(
        appState: AppState(),
        interactors: DIContainer.Interactors(
            offerInteractor: RealOfferInteractor()
        )
    )
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(dependencyInjectorContainer)
        }
    }
}
