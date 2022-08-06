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
    func fetchRecommendations(_ bind: Binding<Loadable<Array<Offer>>>)
}

class RealOfferInteractor: OfferInteractor {
    func fetchOffer(_ bind: Binding<Offer>, id: OfferId) {
        bind.wrappedValue = MockOfferInteractor.sampleOffer1
    }
    
    func fetchOffers(_ bind: Binding<Array<Offer>>, page: Int) {
        bind.wrappedValue = generateOffers()
    }
    
    private func generateOffers() -> Array<Offer> {
        var offers: [Offer] = []
        for i in 1...100 {
            offers.append(
                Offer(
                    id: OfferId(raw: "offer-id-\(i)"),
                    book: Offer.Book(author: "Joanne K. Rowling", title: "Harry Potter i kamień filozoficzny", isbn: "1234567890", condition: .bad),
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
            )
        }
        
        return offers
    }
    
    func fetchRecommendations(_ bind: Binding<Loadable<Array<Offer>>>) {
        bind.wrappedValue = .loaded(generateOffers())
    }

}

public class MockOfferInteractor: OfferInteractor {
    func fetchOffer(_ bind: Binding<Offer>, id: OfferId) {
        bind.wrappedValue = MockOfferInteractor.sampleOffer1
    }
    
    func fetchOffers(_ bind: Binding<Array<Offer>>, page: Int) {
        bind.wrappedValue = [MockOfferInteractor.sampleOffer1, MockOfferInteractor.sampleOffer2]
    }
    
    func fetchRecommendations(_ bind: Binding<Loadable<Array<Offer>>>) {
        bind.wrappedValue = .loaded([MockOfferInteractor.sampleOffer1, MockOfferInteractor.sampleOffer2])
    }

    
    public static let sampleOffer1 = Offer(
        id: OfferId(raw: "offer-id-1"),
        book: Offer.Book(author: "Joanne K. Rowling", title: "Harry Potter i kamień filozoficzny", isbn: "1234567890", condition: .bad),
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

    public static let sampleOffer2 = Offer(
        id: OfferId(raw: "offer-id-2"),
        book: Offer.Book(author: "Joanne K. Rowling", title: "Harry Pottej i Czara Ognia", isbn: "1234567890", condition: .bad),
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
}
