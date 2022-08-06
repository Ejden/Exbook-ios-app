//
//  OfferPrice.swift
//  Exbook
//
//  Created by Adrian Stypinski on 06/08/2022.
//

import SwiftUI

private let formatter = NumberFormatter()

struct PriceSnippet: View {
    let price: Money?
    
    init(_ price: Money?) {
        self.price = price
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.currencyCode = "PLN"
    }
    
    var body: some View {
        if let price = price {
            HStack(spacing: StandardUI.Spacing.extraSmall) {
                Text(formatter.string(for: price.amount) ?? "0.00")
                Text("zł")
            }
        } else {
            Text("Darmowe")
        }
    }
}

struct PriceSnippet_Previews: PreviewProvider {
    static var previews: some View {
        PriceSnippet(.init(amount: 80.49, currency: .pln))
        PriceSnippet(.init(amount: 80.20, currency: .pln))
        PriceSnippet(nil)
    }
}
