//
//  Money.swift
//  Exbook
//
//  Created by Adrian Stypinski on 22/07/2022.
//

import Foundation

public struct Money {
    public let amount: Decimal
    public let currency: Currency
    
    public static func ofPln(_ amount: Decimal) -> Self {
        return Money(amount: amount, currency: .pln)
    }
}

public enum Currency: String {
    case pln = "PLN"
}
