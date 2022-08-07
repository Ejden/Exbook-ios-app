//
//  OfferDetails.swift
//  Exbook
//
//  Created by Adrian Stypinski on 07/08/2022.
//

import SwiftUI

struct OfferDetails: View {
    let offer: DetailedOffer
    
    @State private var quantity: String = ""
        
    var body: some View {
        VStack(alignment: .leading) {
            offerTitleBar()
            Divider()
            imageCarousel()
            offerDescription()
            Divider()
            offerQuickInfo()
            Divider()
            buyActions()
        }
    }
    
    private func offerTitleBar() -> some View {
        VStack(alignment: .leading) {
            Text(offer.book.title)
                .font(.title3)
            Text(offer.book.author)
                .font(.footnote)
        }
    }
    
    private func imageCarousel() -> some View {
        LoadableImage(
            image: offer.images.thumbnail,
            placeholder: .image,
            maxWidth: .infinity,
            maxHeight: 200
        )
    }
    
    private func offerDescription() -> some View {
        VStack(alignment: .leading) {
            Text(offer.book.title)
                .font(.title3)
            HStack {
                Text("Od: \(offer.seller.id.raw)")
                    .font(.footnote)
                StarsCounter(stars: offer.seller.grade)
            }
            OfferTypeBadges(offerType: offer.type)
            HStack {
                Text("Cena zakupu: ")
                    .font(.caption)
                PriceSnippet(offer.price)
                    .font(.title3)
            }
        }
    }
    
    private func offerQuickInfo() -> some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Dostawa już od:")
                PriceSnippet(offer.shipping.cheapestMethod.price)
                    .font(.caption)
            }
            HStack {
                Text("Stan:")
                Text("?")
            }
            HStack {
                Text("Isbn:")
                Text(offer.book.isbn ?? "Brak")
            }
            HStack {
                Text("Dostępnych sztuk:")
                Text("\(offer.inStock)")
            }
        }
    }
    
    private func buyActions() -> some View {
        VStack(alignment: .leading) {
            TextField("", text: $quantity)
                .keyboardType(.decimalPad)
        }
    }
}

struct OfferDetails_Previews: PreviewProvider {
    static var previews: some View {
        OfferDetails(offer: MockOfferInteractor.sampleDetailsOffer)
            .environmentObject(DIContainer.mock)
    }
}
