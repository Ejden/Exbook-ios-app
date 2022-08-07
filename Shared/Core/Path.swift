//
//  Path.swift
//  Exbook
//
//  Created by Adrian Stypinski on 02/08/2022.
//

import Foundation

enum Path {
    case home
    case listing
    case basket
    case account
    case offer(OfferId)
    
    var raw: String {
        switch self {
        case .home:
            return "/home"
        case .listing:
            return "/listing"
        case .basket:
            return "/basket"
        case .account:
            return "/account"
        case .offer(let offerId):
            return "/offer/\(offerId.raw)"
        }
    }
}
