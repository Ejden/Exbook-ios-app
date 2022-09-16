//
//  OfferSnippet.swift
//  Exbook
//
//  Created by Adrian Stypinski on 22/07/2022.
//

import Foundation

public struct Offer: Identifiable {
    public let id: OfferId
    let book: Book
    let images: Images
    let description: String?
    let type: OfferType
    let seller: Seller
    let price: Money?
    let location: String
    let category: Category
    let shippingMethods: [ShippingMethod]
    let stockId: StockId
    
    var canBeBought: Bool { self.type == .exchange_and_buy || self.type == .buy_only }
    var canBeExchanged: Bool { self.type == .exchange_and_buy || self.type == .exchange_only }
}

public struct OfferId: Hashable {
    let raw: String
}

public struct StockId: Hashable {
    let raw: String
}

public extension Offer {
    enum OfferType: String {
        case exchange_and_buy = "EXCHANGE_AND_BUY"
        case exchange_only = "EXCHANGE_ONLY"
        case buy_only = "BUY_ONLY"
    }
}

public extension Offer {
    struct Seller: Identifiable {
        public let id: UserId
    }
}

public extension Offer {
    struct Book {
        let author: String
        let title: String
        let isbn: String?
        let condition: BookCondition
    }
}

public extension Offer {
    struct ShippingMethod: Identifiable {
        public let id: ShippingMethodId
        let price: Money
    }
}

public extension Offer {
    enum BookCondition: String {
        case new = "NEW"
        case perfect = "PERFECT"
        case lightly_used = "LIGHTLY_USED"
        case moderatly_used = "MODERATELY_USED"
        case bad = "BAD"
    }
}

public extension Offer {
    struct Category {
        let id: CategoryId
    }
}

public extension Offer {
    struct Images {
        let thumbnail: RawImage
        let allImages: [RawImage]
    }
}
