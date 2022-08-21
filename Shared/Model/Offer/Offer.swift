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
    enum OfferType {
        case exchange_and_buy
        case exchange_only
        case buy_only
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
    enum BookCondition {
        case new
        case perfect
        case lightly_used
        case moderatly_used
        case bad
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
