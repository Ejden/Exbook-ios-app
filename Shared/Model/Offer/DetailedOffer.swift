//
//  DetailedOffer.swift
//  Exbook
//
//  Created by Adrian Stypinski on 07/08/2022.
//

public struct DetailedOffer: Identifiable {
    public let id: OfferId
    public let book: Book
    public let images: Images
    public let description: String
    public let type: Offer.OfferType
    public let seller: Seller
    public let price: Money?
    public let location: String
    public let category: Category
    public let shipping: Shipping
    public let inStock: Int64
    public let available: Bool
    
    public var canBeBought: Bool { self.type == .exchange_and_buy || self.type == .buy_only }
    public var canBeExchanged: Bool { self.type == .exchange_and_buy || self.type == .exchange_only }
}

extension DetailedOffer {
    public struct Book {
        public let author: String
        public let title: String
        public let isbn: String?
        public let condition: Offer.BookCondition
    }
}

extension DetailedOffer {
    public struct Images {
        public let thumbnail: RawImage
        public let allImages: [RawImage]
    }
}

extension DetailedOffer {
    public struct Seller {
        public let id: UserId
        public let username: String
        public let grade: Double
    }
}

extension DetailedOffer {
    public struct Category {
        public let id: CategoryId
    }
}

extension DetailedOffer {
    public struct Shipping {
        public let shippingMethods: [ShippingMethod]
        public let cheapestMethod: ShippingMethod
    }
}

extension DetailedOffer {
    public struct ShippingMethod: Identifiable {
        public let id: ShippingMethodId
        public let name: String
        public let price: Money
    }
}
