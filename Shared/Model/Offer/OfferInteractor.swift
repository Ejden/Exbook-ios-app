//
//  OfferService.swift
//  Exbook
//
//  Created by Adrian Stypinski on 22/07/2022.
//

import Foundation
import SwiftUI

protocol OfferInteractor {
    func fetchOffer(id: OfferId) async -> Loadable<DetailedOffer>
    func fetchOffers(searchingPhrase: String, page: Int) async -> Array<DetailedOffer>
    func fetchRecommendations() async -> Loadable<Array<OfferRecommendation>>
}

class RealOfferInteractor: OfferInteractor {
    private let offerClient: OfferClient
    private let recommendationsClient: OfferRecommendationClient
    
    init(offerClient: OfferClient, recommendationsClient: OfferRecommendationClient) {
        self.offerClient = offerClient
        self.recommendationsClient = recommendationsClient
    }
    
    func fetchOffer(id: OfferId) async -> Loadable<DetailedOffer> {
        return await offerClient.fetchOffer(id: id)
    }
    
    func fetchOffers(searchingPhrase: String, page: Int) async -> Array<DetailedOffer> {
        return await offerClient.fetchOffers(searchingPhrase: searchingPhrase, page: page)
    }
    
    func fetchRecommendations() async -> Loadable<Array<OfferRecommendation>> {
        return await recommendationsClient.fetchRecommendations()
    }
}

public class MockOfferInteractor: OfferInteractor {
    func fetchOffer(id: OfferId) async -> Loadable<DetailedOffer> {
        return .loaded(Self.sampleDetailsOffer)
    }
    
    func fetchOffers(searchingPhrase: String, page: Int) async -> Array<DetailedOffer> {
        return [Self.sampleDetailsOffer, Self.sampleDetailsOffer]
    }
    
    func fetchRecommendations() async -> Loadable<Array<OfferRecommendation>> {
        return .loaded([Self.sampleRecommendation, Self.sampleRecommendation])
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
        description: "Harry Potter is a series of seven fantasy novels written by British author J. K. Rowling. The novels chronicle the lives of a young wizard, Harry Potter, and his friends Hermione Granger and Ron Weasley, all of whom are students at Hogwarts School of Witchcraft and Wizardry. The main story arc concerns Harry's struggle against Lord Voldemort, a dark wizard who intends to become immortal, overthrow the wizard governing body known as the Ministry of Magic and subjugate all wizards and Muggles (non-magical people). The series was originally published in English by Bloomsbury in the United Kingdom and Scholastic Press in the United States. All versions around the world are printed by Grafica Veneta in Italy.[1] A series of many genres, including fantasy, drama, coming of age, and the British school story (which includes elements of mystery, thriller, adventure, horror, and romance), the world of Harry Potter explores numerous themes and includes many cultural meanings and references.[2] According to Rowling, the main theme is death.[3] Other major themes in the series include prejudice, corruption, and madness.[4]",
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
    
    public static let sampleRecommendation = OfferRecommendation(
        id: OfferId(raw: "offer-id-1"),
        book: OfferRecommendation.Book(author: "Joanne K. Rowling", title: "Harry Potter i kamień filozoficzny", isbn: "1234567890", condition: .perfect),
        images: OfferRecommendation.Images(
            thumbnail: sampleDetailsOffer.images.thumbnail,
            allImages: sampleDetailsOffer.images.allImages
        ),
        type: .buy_only,
        seller: OfferRecommendation.Seller(id: UserId(raw: "user-id"), username: "j.kowalski", firstName: "Jan", lastName: "Kowalski", grade: 3.5),
        price: Money.ofPln(10.50)
    )
}
