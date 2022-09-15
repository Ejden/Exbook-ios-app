//
//  ContentView.swift
//  Shared
//
//  Created by Adrian Stypinski on 18/07/2022.
//

import SwiftUI
import SwiftUIRouter

struct ContentView: View {
    
    var body: some View {
        ZStack {
            Router(initialPath: "/") {
                Route("/") {
                    HomeView()
                }
                Route("/listing") {
                    ListingView()
                }
                Route("/basket") {
                    BasketView()
                }
                Route("/account") {
                    AccountView()
                }
                Route("/offer/:offerId", validator: validateOfferId) { offerId in
                    OfferView(offerId: offerId)
                }
            }
            GeometryReader { reader in
                StandardUI.Color.desk
                    .frame(height: reader.safeAreaInsets.top, alignment: .top)
                    .ignoresSafeArea()
            }
        }
    }
}

private func validateOfferId(routeInfo: RouteInformation) -> OfferId {
    guard let rawOfferId = routeInfo.parameters["offerId"] else {
        return OfferId(raw: "")
    }
    return OfferId(raw: rawOfferId)
}

enum RoutingError: Error {
    case invalidParameter
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDisplayName("Light mode")
            .environmentObject(DIContainer.mock)
        ContentView()
            .preferredColorScheme(.dark)
            .previewDisplayName("Dark mode")
            .environmentObject(DIContainer.mock)
    }
}
