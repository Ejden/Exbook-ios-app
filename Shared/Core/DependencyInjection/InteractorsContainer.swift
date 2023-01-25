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
        let categoryInteractor: CategoryInteractor
        let userService: UserService
        
        init(
            offerInteractor: OfferInteractor,
            imagesInteractor: ImagesInteractor,
            categoryInteractor: CategoryInteractor,
            userService: UserService
        ) {
            self.offerInteractor = offerInteractor
            self.imagesInteractor = imagesInteractor
            self.categoryInteractor = categoryInteractor
            self.userService = userService
        }
    }
}
