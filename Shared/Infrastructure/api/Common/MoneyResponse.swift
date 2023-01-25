//
//  MoneyResponse.swift
//  Exbook
//
//  Created by Adrian Stypinski on 17/09/2022.
//

import Foundation

struct MoneyResponse : Decodable {
    let amount: Decimal
    let currency: String
    
    func toDomain() -> Money {
        return Money(amount: amount, currency: Currency(rawValue: currency)!)
    }
}
