//
//  RecommendationsClientApi.swift
//  Exbook
//
//  Created by Adrian Stypinski on 16/09/2022.
//

import Foundation
import OSLog

class OfferReccomendationClientApi : OfferRecommendationClient {
    private static let logger = Logger()
    private let urlSession: URLSession
    private let baseUrl: String
    
    init(urlSession: URLSession, baseUrl: String) {
        self.urlSession = urlSession
        self.baseUrl = baseUrl
    }
    
    func fetchRecommendations() async -> Loadable<Array<OfferRecommendation>> {
        guard let url = URL(string: "\(baseUrl)/recommendations/offers") else {
            return .failed(URLError.init(URLError.Code(rawValue: 404), userInfo: [:]))
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let parsedData = try JSONDecoder().decode(OfferRecommendationResponse.self, from: data)
            return .loaded(parsedData.recommendations.map { $0.toDomain() })
        } catch let error {
            print(error)
            return .failed(error)
        }
    }
}

fileprivate struct OfferRecommendationResponse: Decodable {
    let recommendations: [OfferRecommendationResponse.OfferRecommendation]
}

extension OfferRecommendationResponse {
    struct OfferRecommendation: Decodable {
        let id: String
        let book: OfferRecommendationResponse.Book
        let images: OfferRecommendationResponse.Images
        let type: String
        let seller: OfferRecommendationResponse.Seller
        let price: MoneyResponse?
    }
}

extension OfferRecommendationResponse {
    struct Book: Decodable {
        let author: String
        let title: String
        let isbn: String?
        let condition: String
    }
}

extension OfferRecommendationResponse {
    struct Images: Decodable {
        let thumbnail: OfferRecommendationResponse.Image
        let allImages: [OfferRecommendationResponse.Image]
    }
}

extension OfferRecommendationResponse {
    struct Image: Decodable {
        let url: String
    }
}

extension OfferRecommendationResponse {
    struct Seller: Decodable {
        let id: String
        let username: String
        let firstName: String
        let lastName: String
        let grade: Double
    }
}

extension OfferRecommendationResponse.OfferRecommendation {
    func toDomain() -> OfferRecommendation {
        return OfferRecommendation(
            id: OfferId(raw: id),
            book: OfferRecommendation.Book(
                author: book.author,
                title: book.title,
                isbn: book.isbn,
                condition: Offer.BookCondition(rawValue: book.condition)!
            ),
            images: OfferRecommendation.Images(
                thumbnail: RawImage(url: URL(string: images.thumbnail.url)!),
                allImages: images.allImages.map { image in
                    RawImage(url: URL(string: image.url)!)
                }
            ),
            type: Offer.OfferType(rawValue: type)!,
            seller: OfferRecommendation.Seller(
                id: UserId(raw: seller.id),
                username: seller.username,
                firstName: seller.firstName,
                lastName: seller.lastName,
                grade: seller.grade
            ),
            price: price?.toDomain()
        )
    }
}
