//
//  RealUserClient.swift
//  Exbook
//
//  Created by Adrian Stypinski on 16/09/2022.
//

import Foundation

class UserClientApi : UserClient {
    private let baseUrl: String
    private let jsonEncoder: JSONEncoder
    private let jsonDecoder: JSONDecoder
    private let loginEndpoint: URL
    
    init(baseUrl: String, jsonEncoder: JSONEncoder, jsonDecoder: JSONDecoder) {
        self.baseUrl = baseUrl
        self.jsonEncoder = jsonEncoder
        self.jsonDecoder = jsonDecoder
        self.loginEndpoint = URL(string: "\(baseUrl)/auth/login") ?? URL(string: "")!
    }
    
    func login(username: String, password: String) async -> LoginStatus {
        let requestData = LoginRequest(username: username, password: password)
        
        
        do {
            let parsedData = try jsonEncoder.encode(requestData)
            var request = URLRequest(url: loginEndpoint, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData)
            request.httpMethod = "POST"
            
            let (_, rawResponse) = try await URLSession.shared.upload(for: request, from: parsedData)
            print(rawResponse)
            guard let response = rawResponse as? HTTPURLResponse else {
                return .unknownError(NSError(domain: "Cannot cast response to HTTPURLResponse", code: 0))
            }
            if response.statusCode == 401 || response.statusCode == 403 {
                return .unauthorized
            }
            guard response.statusCode == 200 else {
                return .unknownError(NSError(domain: "Service returned status: \(response.statusCode)", code: response.statusCode))
            }
            guard let token = response.allHeaderFields["Set-Cookie"] as? String else {
                return .unknownError(NSError(domain: "Cannot cast Set-Cookie header value to string", code: 0))
            }
            do {
                let userToken = try UserToken(from: token)
                return .succesfullLogin(userToken)
            } catch {
                return .unknownError(error)
            }
        } catch {
            return .unknownError(error)
        }
    }
}

fileprivate struct LoginRequest : Encodable {
    let username: String
    let password: String
}

class MockUserClientApi : UserClient {
    func login(username: String, password: String) async -> LoginStatus {
        return .unauthorized
    }
}
