//
//  DataProvidersContainer.swift
//  Exbook
//
//  Created by Adrian Stypinski on 16/09/2022.
//

import Foundation

extension DIContainer {
    class DataProviders {
        let imageProvider: ImageProvider
        let offerClient: OfferClient
        let offerRecommendationClient: OfferRecommendationClient
        
        init(
            imageProvider: ImageProvider,
            offerClient: OfferClient,
            offerRecommendationClient: OfferRecommendationClient
        ) {
            self.imageProvider = imageProvider
            self.offerClient = offerClient
            self.offerRecommendationClient = offerRecommendationClient
        }
    }
}
