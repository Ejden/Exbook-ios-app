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
        let appState = AppState()
        let basicJsonEncoder = JSONEncoder()
        let basicJsonDecoder = JSONDecoder()
        let dataProviders = configureDataProviders(
            urlSession: urlSession,
            baseApiUrl: "http://exbook.pl/api",
            jsonEncoder: basicJsonEncoder,
            jsonDecoder: basicJsonDecoder
        )
        let interactors = configureInteractors(
            dataProviders: dataProviders,
            appState: appState
        )
        
        let container = DIContainer(
            appState: appState,
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
    
    private static func configureInteractors(
        dataProviders: DIContainer.DataProviders,
        appState: AppState
    ) -> DIContainer.Interactors {
        return DIContainer.Interactors(
            offerInteractor: RealOfferInteractor(
                offerClient: dataProviders.offerClient,
                recommendationsClient: dataProviders.offerRecommendationClient
            ),
            imagesInteractor: RealImagesInteractor(imageProvider: dataProviders.imageProvider),
            categoryInteractor: RealCategoryInteractor(),
            userService: RealUserService(userClient: dataProviders.userClient, appState: appState)
        )
    }
    
    private static func configureDataProviders(
        urlSession: URLSession,
        baseApiUrl: String,
        jsonEncoder: JSONEncoder,
        jsonDecoder: JSONDecoder
    ) -> DIContainer.DataProviders {
        return DIContainer.DataProviders(
            imageProvider: RealImageProvider(session: urlSession, baseUrl: ""),
            offerClient: OfferClientApi(urlSession: urlSession, baseUrl: baseApiUrl),
            offerRecommendationClient: OfferReccomendationClientApi(urlSession: urlSession, baseUrl: baseApiUrl),
            userClient: UserClientApi(baseUrl: baseApiUrl, jsonEncoder: jsonEncoder, jsonDecoder: jsonDecoder)
        )
    }
}
