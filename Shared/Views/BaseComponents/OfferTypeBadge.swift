//
//  OfferTypeBadge.swift
//  Exbook
//
//  Created by Adrian Stypinski on 24/07/2022.
//

import SwiftUI

struct OfferTypeBadge: View {
    let badgeType: BadgeType
    var text: String {
        if badgeType == .exchange {
            return "WYMIEŃ"
        } else {
            return "KUP"
        }
    }

    var body: some View {
        Text(text)
            .font(.caption2)
            .frame(minWidth: 0, maxWidth: 50)
            .overlay(
                RoundedRectangle(cornerRadius: 400)
                    .stroke(.green.opacity(0.3))
            )
    }
}

enum BadgeType {
    case buy
    case exchange
}

struct OfferTypeBadge_Previews: PreviewProvider {
    static var previews: some View {
        OfferTypeBadge(badgeType: .buy)
        OfferTypeBadge(badgeType: .exchange)
    }
}
