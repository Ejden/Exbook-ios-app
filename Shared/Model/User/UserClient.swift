//
//  UserClient.swift
//  Exbook
//
//  Created by Adrian Stypinski on 16/09/2022.
//

import Foundation

protocol UserClient {
    func login(username: String, password: String) async -> LoginStatus
}

enum LoginStatus {
    case succesfullLogin(UserToken)
    case unauthorized
    case unknownError(Error?)
}

struct UserToken {
    private static let regex = /(Authorization)(=)(.+)(; )(Max-Age)(=)([0-9]+)(; )(Expires)(=)(.*)(; )(Path)(=)(.*)/
    let authorizationToken: String
    let token: String
    let maxAge: String
    let expires: String
    let path: String
    
    init(authorization: String, token: String, maxAge: String, expires: String, path: String) {
        self.authorizationToken = authorization
        self.token = token
        self.maxAge = maxAge
        self.expires = expires
        self.path = path
    }
    
    init(from authorizationToken: String) throws {
        guard let match = authorizationToken.firstMatch(of: Self.regex) else {
            throw NSError(domain: "Couldn't parse authorization token", code: 0)
        }
        self.authorizationToken = authorizationToken
        self.token = String(match.output.3)
        self.maxAge = String(match.output.7)
        self.expires = String(match.output.11)
        self.path = String(match.output.15)
    }
}
