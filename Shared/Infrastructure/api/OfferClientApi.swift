//
//  RealOfferClient.swift
//  Exbook
//
//  Created by Adrian Stypinski on 16/09/2022.
//

import Foundation
import OSLog

class OfferClientApi : OfferClient {
    private static let logger = Logger()
    private let urlSession: URLSession
    private let baseUrl: String
    
    init (urlSession: URLSession, baseUrl: String) {
        self.urlSession = urlSession
        self.baseUrl = baseUrl
    }
    
    func fetchOffer(id: OfferId) async -> Loadable<DetailedOffer> {
        guard let url = URL(string: "\(baseUrl)/listing/\(id.raw)") else {
            return .failed(URLError.init(URLError.Code(rawValue: 404), userInfo: [:]))
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let parsedData = try JSONDecoder().decode(DetailedOfferResponse.self, from: data)
            return .loaded(parsedData.toDomain())
        } catch let error {
            Self.logger.error("\(error.localizedDescription)")
            return .failed(error)
        }
    }
    
    func fetchOffers(searchingPhrase: String, page: Int) async -> Array<DetailedOffer> {
        let queryItems = [URLQueryItem(name: "search", value: searchingPhrase)]
        guard var url = URLComponents(string: "\(baseUrl)/listing") else {
            return []
        }
        url.queryItems = queryItems
        
        Self.logger.info("OfferClientApi.fetchOffers() - searchingPhrase: \(searchingPhrase), page: \(page)")
        do {
            let (data, _) = try await URLSession.shared.data(from: url.url!)
            let parsedData = try JSONDecoder().decode(PageResponse<DetailedOfferResponse>.self, from: data)
            return parsedData.content.map { $0.toDomain() }
        } catch let error {
            Self.logger.error("\(error.localizedDescription)")
            return []
        }
    }
}

fileprivate struct DetailedOfferResponse : Decodable {
    let id: String;
    let book: DetailedOfferResponse.Book
    let images: DetailedOfferResponse.Images
    let description: String
    let type: String
    let seller: DetailedOfferResponse.Seller
    let price: MoneyResponse?
    let location: String
    let category: DetailedOfferResponse.Category
    let shipping: DetailedOfferResponse.Shipping
    let inStock: Int64
    let available: Bool
}

extension DetailedOfferResponse {
    struct Book : Decodable {
        let author: String
        let title: String
        let isbn: String?
        let condition: String
    }
}

extension DetailedOfferResponse {
    struct Images : Decodable {
        let thumbnail: RawImageResponse
        let allImages: [RawImageResponse]
    }
}

extension DetailedOfferResponse {
    struct Image : Decodable {
        let url: String
    }
}

extension DetailedOfferResponse {
    struct Seller : Decodable {
        let id: String
        let username: String
        let grade: Double
    }
}

extension DetailedOfferResponse {
    struct Money : Decodable {
        let amount: Decimal
        let currency: String
    }
}

extension DetailedOfferResponse {
    struct Category : Decodable {
        let id: String
    }
}

extension DetailedOfferResponse {
    struct Shipping : Decodable {
        let shippingMethods: [DetailedOfferResponse.ShippingMethod]
        let cheapestMethod: DetailedOfferResponse.ShippingMethod
    }
}

extension DetailedOfferResponse {
    struct ShippingMethod : Decodable {
        let id: String
        let name: String
        let price: MoneyResponse
    }
}

extension DetailedOfferResponse {
    func toDomain() -> DetailedOffer {
        return DetailedOffer(
            id: OfferId(raw: id),
            book: DetailedOffer.Book(author: book.author, title: book.title, isbn: book.isbn, condition: Offer.BookCondition(rawValue: book.condition)!),
            images: DetailedOffer.Images(
                thumbnail: images.thumbnail.toDomain(),
                allImages: images.allImages.map { $0.toDomain() }
            ),
            description: description,
            type: Offer.OfferType(rawValue: type)!,
            seller: DetailedOffer.Seller(id: UserId(raw: seller.id), username: seller.username, grade: seller.grade),
            price: price?.toDomain(),
            location: location,
            category: DetailedOffer.Category(id: CategoryId(raw: category.id)),
            shipping: DetailedOffer.Shipping(
                shippingMethods: shipping.shippingMethods.map { $0.toDomain() },
                cheapestMethod: shipping.cheapestMethod.toDomain()
            ),
            inStock: inStock,
            available: available
        )
    }
}

extension DetailedOfferResponse.ShippingMethod {
    func toDomain() -> DetailedOffer.ShippingMethod {
        return DetailedOffer.ShippingMethod(id: ShippingMethodId(raw: id), name: name, price: price.toDomain())
    }
}
