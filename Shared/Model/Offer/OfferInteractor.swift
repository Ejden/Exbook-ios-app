//
//  OfferService.swift
//  Exbook
//
//  Created by Adrian Stypinski on 22/07/2022.
//

import Foundation
import SwiftUI

protocol OfferInteractor {
    func fetchOffer(_ bind: Binding<Loadable<Offer>>, id: OfferId)
    func fetchDetailedOffer(_ bind: LoadableBind<DetailedOffer>, id: OfferId)
    func fetchOffers(_ bind: Binding<Array<Offer>>, page: Int)
    func fetchRecommendations(_ bind: Binding<Loadable<Array<Offer>>>)
}

class RealOfferInteractor: OfferInteractor {
    func fetchOffer(_ bind: Binding<Loadable<Offer>>, id: OfferId) {
        bind.wrappedValue = .loaded(MockOfferInteractor.sampleOffer1)
    }
    
    func fetchDetailedOffer(_ bind: LoadableBind<DetailedOffer>, id: OfferId) {
        bind.wrappedValue = .loaded(MockOfferInteractor.sampleDetailsOffer)
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
    func fetchOffer(_ bind: Binding<Loadable<Offer>>, id: OfferId) {
        bind.wrappedValue = .loaded(MockOfferInteractor.sampleOffer1)
    }
    
    func fetchDetailedOffer(_ bind: LoadableBind<DetailedOffer>, id: OfferId) {
        bind.wrappedValue = .loaded(Self.sampleDetailsOffer)
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
    
    public static let sampleDetailsOffer = DetailedOffer(
        id: OfferId(raw: "offer-id-1"),
        book: DetailedOffer.Book(author: "Joanne K. Rowling", title: "Harry Potter i kamień filozoficzny", isbn: "1234567890", condition: .bad),
        images: DetailedOffer.Images(
            thumbnail: RawImage(url: URL(string: "https://www.ukrgate.com/eng/wp-content/uploads/2021/02/The-Ukrainian-Book-Institute-Purchases-380.9-Thousand-Books-for-Public-Libraries1.jpeg")!),
            allImages: [RawImage(url: URL(string: "https://www.ukrgate.com/eng/wp-content/uploads/2021/02/The-Ukrainian-Book-Institute-Purchases-380.9-Thousand-Books-for-Public-Libraries1.jpeg")!)]
        ),
        description: "Some offer description",
        type: .exchange_and_buy,
        seller: DetailedOffer.Seller(id: UserId(raw: "user-id"), username: "Franek", grade: 3.5),
        price: Money(amount: Decimal(10.53), currency: .pln),
        location: "Warszawa",
        category: DetailedOffer.Category(id: CategoryId(raw: "category-id")),
        shipping: DetailedOffer.Shipping(
            shippingMethods: [
                DetailedOffer.ShippingMethod(id: ShippingMethodId(raw: "shipping-method-1"), name: "Allegro One Box", price: Money(amount: Decimal(6.99), currency: .pln)),
                DetailedOffer.ShippingMethod(id: ShippingMethodId(raw: "shipping-method-1"), name: "Odbiór Osobisty", price: Money(amount: Decimal(0.00), currency: .pln)),
                DetailedOffer.ShippingMethod(id: ShippingMethodId(raw: "shipping-method-1"), name: "Kurier InPost", price: Money(amount: Decimal(11.99), currency: .pln))
            ],
            cheapestMethod: DetailedOffer.ShippingMethod(id: ShippingMethodId(raw: "shipping-method-1"), name: "Allegro One Box", price: Money(amount: Decimal(6.99), currency: .pln))
        ),
        inStock: 64,
        available: true
    )
}
