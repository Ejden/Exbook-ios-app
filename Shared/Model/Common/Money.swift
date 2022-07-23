//
//  Money.swift
//  Exbook
//
//  Created by Adrian Stypinski on 22/07/2022.
//

import Foundation

struct Money {
    let amount: Decimal
    let currency: Currency
}

enum Currency {
    case pln
}
