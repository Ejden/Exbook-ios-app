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
    @State var offers: [DetailedOffer] = []
    @State var searchingPhrase: String = ""
    
    var body: some View {
        MainView {
            VStack(spacing: StandardUI.Spacing.noSpacing) {
                ListingSearchBar(searchingPhrase: $searchingPhrase) { queryParams in
                    Task {
                        let loadedOffers = await injected.interactors.offerInteractor.fetchOffers(searchingPhrase: queryParams.searchingPhrase, page: 0)
                        offers = loadedOffers
                    }
                }
                    .padding(.leading, StandardUI.Spacing.small)
                    .padding(.trailing, StandardUI.Spacing.small)
                    .padding(.bottom, StandardUI.Spacing.small)
                    .background(StandardUI.Color.desk)
                if searchingPhrase.isEmpty {
                    searchView
                } else if offers.isEmpty {
                    noOffers
                } else {
                    offersList
                }
            }
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
                            navigator.navigate(.offer(offer.id))
                        }
                    Divider()
                }
            }
        }
        .padding(.top, StandardUI.Spacing.small)
        .background(StandardUI.Color.desk)
    }
}

struct ListingView_Previews: PreviewProvider {
    static var previews: some View {
        ListingView(offers: [MockOfferInteractor.sampleDetailsOffer, MockOfferInteractor.sampleDetailsOffer], searchingPhrase: "Harry")
            .environmentObject(DIContainer.mock)
            .environmentObject(Navigator.initWith(initialPath: .listing))
    }
}
