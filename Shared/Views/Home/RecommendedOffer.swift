//
//  RecommendedOffer.swift
//  Exbook
//
//  Created by Adrian Stypinski on 02/08/2022.
//

import SwiftUI

struct RecommendedOffer: View {
    @EnvironmentObject private var di: DIContainer
    let offer: Offer
    
    var body: some View {
        VStack(alignment: .leading, spacing: StandardUI.Spacing.extraSmall) {
            LoadableImage(
                image: offer.images.thumbnail,
                placeholder: .image,
                width: 150,
                height: 90
            )
            Text(offer.book.title)
                .lineLimit(2)
                .truncationMode(.tail)
            Text(offer.book.author)
                .font(.footnote)
            OfferTypeBadges(offerType: offer.type)
            PriceSnippet(offer.price)
        }
        .frame(maxWidth: 150, alignment: .leading)
    }
}

struct RecommendedOffer_Previews: PreviewProvider {
    static var previews: some View {
        RecommendedOffer(offer: MockOfferInteractor.sampleOffer1)
            .environmentObject(DIContainer.mock)
    }
}
