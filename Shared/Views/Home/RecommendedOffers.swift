//
//  RecommendedOffers.swift
//  Exbook
//
//  Created by Adrian Stypinski on 02/08/2022.
//

import SwiftUI
import SwiftUIRouter

struct RecommendedOffers: View {
    @EnvironmentObject var container: DIContainer
    @EnvironmentObject var navigator: Navigator
    @State private var offers: Loadable<Array<Offer>> = .loading
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Rekomendowane oferty")
                .font(.title2)
            switch offers {
            case .loading: ProgressView()
            case .failed: Text("Error")
            case let .loaded(loadedOffers): renderOffers(loadedOffers)
            }
        }
        .padding()
        .onAppear {
            container.interactors.offerInteractor.fetchRecommendations($offers)
        }
    }
    
    @ViewBuilder func renderOffers(_ loadedOffers: Array<Offer>) -> some View {
        ScrollView(.horizontal) {
            LazyHStack {
                ForEach(loadedOffers) { offer in
                    RecommendedOffer(offer: offer)
                        .onTapGesture {
                            navigator.navigate(.offer(offer.id))
                        }
                }
            }
        }
    }
}

struct RecommendedOffers_Previews: PreviewProvider {
    static var previews: some View {
        RecommendedOffers()
            .environmentObject(DIContainer.mock)
            .environmentObject(Navigator.init())
    }
}
