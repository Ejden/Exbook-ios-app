//
//  InteractorsContainer.swift
//  Exbook
//
//  Created by Adrian Stypinski on 23/07/2022.
//

import Foundation

extension DIContainer {
    class Interactors {
        let offerInteractor: OfferInteractor
        
        init(offerInteractor: OfferInteractor) {
            self.offerInteractor = offerInteractor
        }
    }
}
