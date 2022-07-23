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
                Text(offer.book.title)
            }
            .listStyle(DefaultListStyle())
        }
    }
}

private struct ListingOfferImage: View {
    var body: some View {
        
    }
}

struct ListingView_Previews: PreviewProvider {
    static var previews: some View {
        ListingView()
            .environmentObject(DIContainer.mock)
            .environmentObject(Navigator.init(initialPath: "/listing"))
    }
}
