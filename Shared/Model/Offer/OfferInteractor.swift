//
//  OfferService.swift
//  Exbook
//
//  Created by Adrian Stypinski on 22/07/2022.
//

import Foundation
import SwiftUI

protocol OfferInteractor {
    func fetchOffer(_ bind: Binding<Offer>, id: OfferId)
    func fetchOffers(_ bind: Binding<Array<Offer>>, page: Int)
}

class RealOfferInteractor: OfferInteractor {
    func fetchOffer(_ bind: Binding<Offer>, id: OfferId) {
        bind.wrappedValue = sampleOffer1
    }
    
    func fetchOffers(_ bind: Binding<Array<Offer>>, page: Int) {
        bind.wrappedValue = [sampleOffer1, sampleOffer2]
    }
}

class MockOfferInteractor: OfferInteractor {
    func fetchOffer(_ bind: Binding<Offer>, id: OfferId) {
        bind.wrappedValue = sampleOffer1
    }
    
    func fetchOffers(_ bind: Binding<Array<Offer>>, page: Int) {
        bind.wrappedValue = [sampleOffer1, sampleOffer2]
    }
}

private let sampleOffer1 = Offer(
    id: OfferId(raw: "offer-id-1"),
    book: Offer.Book(author: "Author", title: "Title", isbn: "1234567890", condition: .bad),
    images: Offer.Images(
        thumbnail: RawImage(url: URL(string: "https://www.ukrgate.com/eng/wp-content/uploads/2021/02/The-Ukrainian-Book-Institute-Purchases-380.9-Thousand-Books-for-Public-Libraries1.jpeg")!),
        allImages: [RawImage(url: URL(string: "https://www.ukrgate.com/eng/wp-content/uploads/2021/02/The-Ukrainian-Book-Institute-Purchases-380.9-Thousand-Books-for-Public-Libraries1.jpeg")!)]
    ),
    description: "Some offer description",
    type: .exchange_and_buy,
    seller: Offer.Seller(id: UserId(raw: "user-id")),
    price: Money(amount: Decimal(10.53), currency: .pln),
    location: "Warsaw",
    category: Offer.Category(id: CategoryId(raw: "category-id")),
    shippingMethods: [Offer.ShippingMethod(id: ShippingMethodId(raw: "shipping-method-id"), price: Money(amount: Decimal(12.59), currency: .pln))],
    stockId: StockId(raw: "stock-id")
)

private let sampleOffer2 = Offer(
    id: OfferId(raw: "offer-id-2"),
    book: Offer.Book(author: "Author", title: "Title", isbn: "1234567890", condition: .bad),
    images: Offer.Images(
        thumbnail: RawImage(url: URL(string: "https://www.ukrgate.com/eng/wp-content/uploads/2021/02/The-Ukrainian-Book-Institute-Purchases-380.9-Thousand-Books-for-Public-Libraries1.jpeg")!),
        allImages: [RawImage(url: URL(string: "https://www.ukrgate.com/eng/wp-content/uploads/2021/02/The-Ukrainian-Book-Institute-Purchases-380.9-Thousand-Books-for-Public-Libraries1.jpeg")!)]
    ),
    description: "Some offer description",
    type: .exchange_and_buy,
    seller: Offer.Seller(id: UserId(raw: "user-id")),
    price: Money(amount: Decimal(10.53), currency: .pln),
    location: "Warsaw",
    category: Offer.Category(id: CategoryId(raw: "category-id")),
    shippingMethods: [Offer.ShippingMethod(id: ShippingMethodId(raw: "shipping-method-id"), price: Money(amount: Decimal(12.59), currency: .pln))],
    stockId: StockId(raw: "stock-id")
)
