//
//  RealOfferClient.swift
//  Exbook
//
//  Created by Adrian Stypinski on 16/09/2022.
//

import Foundation

class OfferClientApi : OfferClient {
    private let urlSession: URLSession
    private let baseUrl: String
    
    init (urlSession: URLSession, baseUrl: String) {
        self.urlSession = urlSession
        self.baseUrl = baseUrl
    }
    
    func fetchOffer(id: OfferId) async -> Loadable<DetailedOffer> {
        
    }
    
    func fetchOffers(page: Int) async -> Loadable<Array<DetailedOffer>> {
        
    }
}
