//
//  OfferView.swift
//  Exbook
//
//  Created by Adrian Stypinski on 24/07/2022.
//

import SwiftUI
import SwiftUIRouter

struct OfferView: View {
    var offerId: OfferId
    
    @EnvironmentObject private var container: DIContainer
    @State private var offer: Loadable<DetailedOffer> = .loading
    
    init(offerId: OfferId) {
        self.offerId = offerId
    }
    
    var body: some View {
        MainView {
            Group {
                switch offer {
                case .loading: loadingView
                case let .loaded(loadedOffer): offerContent(loadedOffer)
                case .failed: Text("Error")
                }
            }
        }
        .onAppear {
            container.interactors.offerInteractor.fetchDetailedOffer($offer, id: offerId)
        }
    }
    
    private var loadingView = VStack {
        Spacer()
        ProgressView()
        Spacer()
    }
    
    private func offerContent(_ loadedOffer: DetailedOffer) -> some View {
        ScrollView {
            VStack {
                OfferDetails(offer: loadedOffer)
                    .padding()
                    .background(StandardUI.Color.darkGray)
                OfferDescription(offer: loadedOffer)
                    .padding()
                    .background(StandardUI.Color.darkGray)
                OfferOtherRecommendations()
                    .padding()
                    .background(StandardUI.Color.darkGray)
                OfferDeliveryOptions(offer: loadedOffer)
                    .padding()
                    .background(StandardUI.Color.darkGray)
            }
        }
    }
}

struct OfferView_Previews: PreviewProvider {
    static var previews: some View {
        OfferView(offerId: MockOfferInteractor.sampleOffer1.id)
            .environmentObject(DIContainer.mock)
            .environmentObject(Navigator.init())
    }
}
