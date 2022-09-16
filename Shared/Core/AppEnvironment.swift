//
//  AppEnvironment.swift
//  Exbook
//
//  Created by Adrian Stypinski on 23/07/2022.
//

import Foundation

struct AppEnvironment {
    let container: DIContainer
}

extension AppEnvironment {
    static func create() -> AppEnvironment {
        let urlSession = configureSession()
        let dataProviders = configureDataProviders(urlSession: urlSession, baseApiUrl: "http://exbook.pl/api")
        let interactors = configureInteractors(dataProviders: dataProviders)
        
        let container = DIContainer(
            appState: AppState(),
            interactors: interactors
        )
        
        return AppEnvironment(container: container)
    }
    
    private static func configureSession() -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 120
        configuration.waitsForConnectivity = true
        configuration.httpMaximumConnectionsPerHost = 5
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        configuration.urlCache = .shared
        return URLSession(configuration: configuration)
    }
    
    private static func configureInteractors(dataProviders: DIContainer.DataProviders) -> DIContainer.Interactors {
        return DIContainer.Interactors(
            offerInteractor: RealOfferInteractor(
                offerClient: dataProviders.offerClient,
                recommendationsClient: dataProviders.offerRecommendationClient
            ),
            imagesInteractor: RealImagesInteractor(imageProvider: dataProviders.imageProvider),
            categoryInteractor: RealCategoryInteractor()
        )
    }
    
    private static func configureDataProviders(urlSession: URLSession, baseApiUrl: String) -> DIContainer.DataProviders {
        return DIContainer.DataProviders(
            imageProvider: RealImageProvider(session: urlSession, baseUrl: ""),
            offerClient: OfferClientApi(urlSession: urlSession, baseUrl: ""),
            offerRecommendationClient: OfferReccomendationClientApi(urlSession: urlSession, baseUrl: baseApiUrl)
        )
    }
}
