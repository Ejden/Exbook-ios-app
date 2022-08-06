//
//  OfferTypeBadges.swift
//  Exbook
//
//  Created by Adrian Stypinski on 06/08/2022.
//

import SwiftUI

struct OfferTypeBadges: View {
    let offerType: Offer.OfferType
    
    var body: some View {
        switch offerType {
        case .exchange_only:
            OfferTypeBadge(badgeType: .exchange)
        case .buy_only:
            OfferTypeBadge(badgeType: .buy)
        case .exchange_and_buy:
            HStack {
                OfferTypeBadge(badgeType: .exchange)
                OfferTypeBadge(badgeType: .buy)
            }
        }
    }
}

struct OfferTypeBadges_Previews: PreviewProvider {
    static var previews: some View {
        OfferTypeBadges(offerType: .buy_only)
        OfferTypeBadges(offerType: .exchange_only)
        OfferTypeBadges(offerType: .exchange_and_buy)
    }
}
