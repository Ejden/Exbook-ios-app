//
//  DetailedOffer.swift
//  Exbook
//
//  Created by Adrian Stypinski on 07/08/2022.
//

public struct DetailedOffer: Identifiable {
    public let id: OfferId
    let book: Book
    let images: Images
    let description: String
    let type: Offer.OfferType
    let seller: Seller
    let price: Money?
    let location: String
    let category: Category
    let shipping: Shipping
    let inStock: Int64
    let available: Bool
    
    var canBeBought: Bool { self.type == .exchange_and_buy || self.type == .buy_only }
    var canBeExchanged: Bool { self.type == .exchange_and_buy || self.type == .exchange_only }
}

extension DetailedOffer {
    struct Book {
        let author: String
        let title: String
        let isbn: String?
        let condition: Offer.BookCondition
    }
}

extension DetailedOffer {
    struct Images {
        let thumbnail: RawImage
        let allImages: [RawImage]
    }
}

extension DetailedOffer {
    struct Seller {
        let id: UserId
        let username: String
        let grade: Double
    }
}

extension DetailedOffer {
    struct Category {
        let id: CategoryId
    }
}

extension DetailedOffer {
    struct Shipping {
        let shippingMethods: [ShippingMethod]
        let cheapestMethod: ShippingMethod
    }
}

extension DetailedOffer {
    struct ShippingMethod: Identifiable {
        let id: ShippingMethodId
        let name: String
        let price: Money
    }
}
