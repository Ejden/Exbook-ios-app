//
//  ListingView.swift
//  Exbook
//
//  Created by Adrian Stypinski on 18/07/2022.
//

import SwiftUI
import SwiftUIRouter

struct ListingView: View {
    @EnvironmentObject var injected: DIContainer
    @State var offers: [Offer] = []
    
    var body: some View {
        NavigableView {
            VStack {
                ListingSearchBar()
                if offers.isEmpty {
                    noOffers
                } else {
                    offersList
                }
            }
        }
        .onAppear {
            injected.interactors.offerInteractor.fetchOffers($offers, page: 0)
        }
    }
    
    @ViewBuilder var noOffers: some View {
        Text("Brak ofert")
    }
    
    @ViewBuilder var offersList: some View {
        VStack {
            List(offers) { offer in
                HStack {
                    Text(offer.book.title)
                    ListingOfferImage(rawImage: offer.images.thumbnail)
                }
            }
            .listStyle(DefaultListStyle())
        }
    }
}

private struct ListingOfferImage: View {
    @EnvironmentObject var injected: DIContainer
    var rawImage: RawImage
    @State private var image: UIImage = UIImage.init()
    
    var body: some View {
        HStack {
            if let unwrappedImg = image {
                Image(uiImage: unwrappedImg)
            } else {
                Text("Loading...")
            }
        }
        .onAppear {
            injected.interactors.imagesInteractor.load(bind: $image, image: rawImage)
        }
    }
}

struct ListingView_Previews: PreviewProvider {
    static var previews: some View {
        ListingView()
            .environmentObject(DIContainer.mock)
            .environmentObject(Navigator.init(initialPath: "/listing"))
    }
}
