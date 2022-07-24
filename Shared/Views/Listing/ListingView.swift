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
    @EnvironmentObject var navigator: Navigator
    @State var offers: [Offer] = []
    @State var searchingPhrase: String = ""
    
    var body: some View {
        NavigableView {
            VStack {
                ListingSearchBar(searchingPhrase: $searchingPhrase)
                    .padding(.leading, StandardUI.Spacing.small)
                    .padding(.trailing, StandardUI.Spacing.small)
                if searchingPhrase.isEmpty {
                    searchView
                } else if offers.isEmpty {
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
    
    @ViewBuilder var searchView: some View {
        Spacer()
        Text("Brak historii wyszukań")
            .foregroundColor(.gray)
        Spacer()
    }
    
    @ViewBuilder var noOffers: some View {
        Text("Brak ofert")
    }
    
    @ViewBuilder var offersList: some View {
        ScrollView {
            LazyVStack {
                ForEach(offers) { (offer) in
                    ListingOfferRow(offer: offer)
                        .onTapGesture {
                            navigator.navigate("/offer")
                        }
                    Divider()
                }
            }
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
