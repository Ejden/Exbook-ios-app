//
//  OfferSnippet.swift
//  Exbook
//
//  Created by Adrian Stypinski on 22/07/2022.
//

import Foundation

struct Offer: Identifiable {
    let id: OfferId
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
}

struct OfferId: Hashable {
    let raw: String
}

struct StockId: Hashable {
    let raw: String
}

extension Offer {
    enum OfferType {
        case exchange_and_buy
        case exchange_only
        case buy_only
    }
}

extension Offer {
    struct Seller: Identifiable {
        let id: UserId
    }
}

extension Offer {
    struct Book {
        let author: String
        let title: String
        let isbn: String?
        let condition: BookCondition
    }
}

extension Offer {
    struct ShippingMethod: Identifiable {
        let id: ShippingMethodId
        let price: Money
    }
}

extension Offer {
    enum BookCondition {
        case new
        case perfect
        case lightly_used
        case moderatly_used
        case bad
    }
}

extension Offer {
    struct Category {
        let id: CategoryId
    }
}

extension Offer {
    struct Images {
        let thumbnail: Image
        let allImages: [Image]
    }
}
