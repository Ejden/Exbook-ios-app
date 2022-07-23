//
//  DIContainer.swift
//  Exbook
//
//  Created by Adrian Stypinski on 23/07/2022.
//

import Foundation

class DIContainer: ObservableObject {
    let appState: AppState
    let interactors: Interactors
    
    init(appState: AppState, interactors: Interactors) {
        self.appState = appState
        self.interactors = interactors
    }
    
    static var mock = DIContainer(
        appState: AppState(),
        interactors: Interactors(
            offerInteractor: MockOfferInteractor()
        )
    )
}
