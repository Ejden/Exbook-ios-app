//
//  APICall.swift
//  Exbook
//
//  Created by Adrian Stypinski on 23/07/2022.
//

import Foundation

protocol ApiCall {
    var path: String { get }
    var method: HttpMethod { get }
    var headers: [String: String]? { get }
    func body() throws -> Data?
}

enum ApiError: Swift.Error {
    case invalidURL
    case httpCode(HttpCode)
    case unexpectedResponse
    case imageDeserialization
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

typealias HttpCode = Int
typealias HttpCodes = Range<HttpCode>

extension HttpCodes {
    static let success = 200 ..< 300
}

extension ApiCall {
    func urlRequest(baseUrl: String) throws -> URLRequest  {
        guard let url = URL(string: baseUrl + path) else {
            throw ApiError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = try body()
        
        return request
    }
}
