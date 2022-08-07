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
        let interactors = configureInteractors(imageProvider: RealImageProvider(session: urlSession, baseUrl: ""))
        
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
    
    private static func configureInteractors(
        imageProvider: ImageProvider
    ) -> DIContainer.Interactors {
        return DIContainer.Interactors(
            offerInteractor: RealOfferInteractor(),
            imagesInteractor: RealImagesInteractor(imageProvider: imageProvider),
            categoryInteractor: RealCategoryInteractor()
        )
    }
}
