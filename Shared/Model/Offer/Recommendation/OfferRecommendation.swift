//
//  OfferRecommendation.swift
//  Exbook
//
//  Created by Adrian Stypinski on 16/09/2022.
//

import Foundation

public struct OfferRecommendation: Identifiable {
    public let id: OfferId
    public let book: Book
    public let images: Images
    public let type: Offer.OfferType
    public let seller: Seller
    public let price: Money?
}

extension OfferRecommendation {
    public struct Book {
        public let author: String
        public let title: String
        public let isbn: String?
        public let condition: Offer.BookCondition
    }
}

extension OfferRecommendation {
    public struct Images {
        public let thumbnail: RawImage
        public let allImages: [RawImage]
    }

}

extension OfferRecommendation {
    public struct Seller: Identifiable {
        public let id: UserId
        public let username: String
        public let firstName: String
        public let lastName: String
        public let grade: Double
    }
}
