//
//  ListingOfferRow.swift
//  Exbook
//
//  Created by Adrian Stypinski on 24/07/2022.
//

import SwiftUI

struct ListingOfferRow: View {
    let offer: Offer
    
    init(offer: Offer) {
        self.offer = offer
        print("Initialied offer \(offer.id.raw)")
    }
    
    var body: some View {
        HStack(alignment: .top) {
            ListingOfferImage(thumbnail: offer.images.thumbnail)
            VStack(alignment: .leading, spacing: StandardUI.Spacing.small) {
                Text(offer.book.title)
                Text(offer.book.author)
                    .font(.callout)
                badges
                HStack {
                    PriceSnippet(offer.price)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.trailing)
            }
        }
        .padding(.leading, StandardUI.Spacing.small)
    }
    
    @ViewBuilder var badges: some View {
        switch offer.type {
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

private struct ListingOfferImage: View {
    @EnvironmentObject var injected: DIContainer
    var thumbnail: RawImage
    @State private var image: Loadable<UIImage> = .loading
    
    var body: some View {
        HStack {
            switch image {
            case let .loaded(img): renderImage(uiImage: img)
            default: placeholder
            }
        }
        .onAppear {
            injected.interactors.imagesInteractor.load(bind: $image, image: thumbnail)
        }
    }
    
    func renderImage(uiImage: UIImage) -> some View {
        Image(uiImage: uiImage)
            .resizable()
            .frame(width: 120, height: 80, alignment: .leading)
            .cornerRadius(10)
    }
    
    var placeholder: some View = Image(systemName: "photo")
        .resizable()
        .frame(width: 120, height: 80, alignment: .leading)
}

struct ListingOfferRow_Preview: PreviewProvider {
    static var previews: some View {
        ListingOfferRow(offer: MockOfferInteractor.sampleOffer1)
            .preferredColorScheme(.light)
            .previewDisplayName("Light mode")
            .environmentObject(DIContainer.mock)
//        ListingOfferRow(offer: MockOfferInteractor.sampleOffer1)
//            .previewDisplayName("Dark mode")
//            .preferredColorScheme(.dark)
//            .environmentObject(DIContainer.mock)
    }
}
