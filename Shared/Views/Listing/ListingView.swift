//
//  ListingView.swift
//  Exbook
//
//  Created by Adrian Stypinski on 18/07/2022.
//

import SwiftUI

struct ListingView: View {
    @EnvironmentObject var container: DIContainer
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
        }.onAppear {
            container.interactors.offerInteractor.fetchOffers($offers, page: 0)
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
        }
    }
}

struct ListingView_Previews: PreviewProvider {
    static var previews: some View {
        ListingView()
    }
}
