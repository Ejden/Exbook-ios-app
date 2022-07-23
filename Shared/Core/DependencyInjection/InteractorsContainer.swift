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
        let imagesInteractor: ImagesInteractor
        
        init(
            offerInteractor: OfferInteractor,
            imagesInteractor: ImagesInteractor
        ) {
            self.offerInteractor = offerInteractor
            self.imagesInteractor = imagesInteractor
        }
    }
}
