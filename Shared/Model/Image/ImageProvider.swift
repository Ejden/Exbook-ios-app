//
//  ImageProvider.swift
//  Exbook
//
//  Created by Adrian Stypinski on 23/07/2022.
//

import Foundation
import Combine
import UIKit

protocol ImageProvider: WebResourceProvider {
    func fetchImage(url: URL) -> AnyPublisher<UIImage, Error>
}

class RealImageProvider: ImageProvider {
    let session: URLSession
    let baseUrl: String
    let bgQueue: DispatchQueue = DispatchQueue(label: "image_bg_queue")
    
    init(session: URLSession, baseUrl: String) {
        self.session = session
        self.baseUrl = baseUrl
    }
    
    func fetchImage(url: URL) -> AnyPublisher<UIImage, Error> {
        return download(url: url)
            .subscribe(on: bgQueue)
            .receive(on: DispatchQueue.main)
            .extractUnderlyingError()
            .eraseToAnyPublisher()
    }
    
    private func download(url: URL) -> AnyPublisher<UIImage, Error> {
        let request = URLRequest(url: url)
        return session
            .dataTaskPublisher(for: request)
            .tryMap { data -> UIImage in
                guard let image = UIImage(data: data.data) else {
                    throw ApiError.imageDeserialization
                }
                return image
            }
            .eraseToAnyPublisher()
    }
}
