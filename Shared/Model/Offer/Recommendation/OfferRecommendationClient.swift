//
//  OfferRecommendationClient.swift
//  Exbook
//
//  Created by Adrian Stypinski on 16/09/2022.
//

import Foundation

protocol OfferRecommendationClient {
    func fetchRecommendations() async -> Loadable<Array<OfferRecommendation>>
}
