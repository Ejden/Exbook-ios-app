//
//  WebResourceProvider.swift
//  Exbook
//
//  Created by Adrian Stypinski on 23/07/2022.
//

import Foundation
import Combine

protocol WebResourceProvider {
    var session: URLSession { get }
    var baseUrl: String { get }
    var bgQueue: DispatchQueue { get }
}

extension WebResourceProvider {
    func call<Value: Decodable>(endpoint: ApiCall, httpsCodes: HttpCodes = .success) -> AnyPublisher<Value, Error> {
        do {
            let request = try endpoint.urlRequest(baseUrl: baseUrl)
            return session
                .dataTaskPublisher(for: request)
                .requestJSON(httpsCodes: httpsCodes)
        } catch let error {
            
        }
    }
}

extension Publisher where Output == URLSession.DataTaskPublisher.Output {
    func requestData(httpCodes: HttpCodes = .success) -> AnyPublisher<Data, Error> {
        return tryMap { output in
            assert(!Thread.isMainThread)
            guard let code = (output.1 as? HTTPURLResponse)?.statusCode else {
                throw ApiError.unexpectedResponse
            }
            guard httpCodes.contains(code) else {
                throw ApiError.httpCode(code)
            }
            return output.0
        }
        .extractUnderlyingError()
        .eraseToAnyPublisher()
    }
    
    func extractUnderlyingError() -> Publishers.MapError<Self, Failure> {
        mapError { ($0.underlyingError as? Failure) ?? $0 }
    }
    
    func requestJSON<Value>(httpCodes: HttpCodes) -> AnyPublisher<Value, Error> where Value: Decodable {
        return requestData(httpCodes: httpCodes)
            .decode(type: Value.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

extension Error {
    var underlyingError: Error? {
        let nsError = self as NSError
        if nsError.domain == NSURLErrorDomain && nsError.code == -1009 {
            return self
        }
        return nsError.userInfo[NSUnderlyingErrorKey] as? Error
    }
}
