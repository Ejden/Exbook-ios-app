//
//  OfferProvider.swift
//  Exbook
//
//  Created by Adrian Stypinski on 16/09/2022.
//

import Foundation

protocol OfferClient {
    func fetchOffer(id: OfferId) async -> Loadable<DetailedOffer>
    func fetchOffers(searchingPhrase: String, page: Int) async -> Array<DetailedOffer>
}
