//
//  NavigableView.swift
//  Exbook
//
//  Created by Adrian Stypinski on 20/07/2022.
//

import SwiftUI
import SwiftUIRouter

struct NavigableView<Content: View>: View {
    var content: () -> Content
    
    var body: some View {
        VStack(spacing: StandardUI.Spacing.noSpacing) {
            content()
            Spacer()
            CommonNavigationBar()
        }
        .ignoresSafeArea(edges: .horizontal)
        .frame(maxWidth: .infinity)
    }
}

struct CommonNavigationBar: View {
    @EnvironmentObject var navigator: Navigator
    var activeItem: Int {
        switch navigator.path {
        case "/":
            return 0
        case "/listing":
            return 1
        case "/basket":
            return 2
        case "/account":
            return 3
        default:
            return -1
        }
    }
    
    var body: some View {
        HStack {
            Spacer()
            NavigationItem(text: "Home", icon: "house.fill", path: "/", isActive: activeItem == 0) { path in
                navigator.navigateAndClear(path: path)
            }
            Spacer()
            NavigationItem(text: "Search", icon: "magnifyingglass", path: "/listing", isActive: activeItem == 1) { path in
                navigator.navigateAndClear(path: path)
            }
            Spacer()
            NavigationItem(text: "Basket", icon: "cart.fill", path: "/basket", isActive: activeItem == 2) { path in
                navigator.navigateAndClear(path: path)
            }
            Spacer()
            NavigationItem(text: "Account", icon: "person.fill", path: "/account", isActive: activeItem == 3) { path in
                navigator.navigateAndClear(path: path)
            }
            Spacer()
        }
        .padding(.top, StandardUI.Spacing.small)
        .background(.ultraThickMaterial)
    }
}

struct NavigationItem: View {
    var text: String
    var icon: String
    var path: String
    var isActive: Bool
    var onClick: (_ path: String) -> Void
    private var color: Color { self.isActive ? StandardUI.Color.primaryBlue : StandardUI.Color.gray }
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .foregroundColor(color)
            Text(text)
        }
        .onTapGesture {
            onClick(path)
        }
    }
}

private extension Navigator {
    func navigateAndClear(path: String) {
        self.navigate(path)
        self.clear()
    }
}

struct NavigableView_Previews: PreviewProvider {
    static var previews: some View {
        NavigableView() {
            List(
                [
                    MockOfferInteractor.sampleOffer1,
                    MockOfferInteractor.sampleOffer1,
                    MockOfferInteractor.sampleOffer1,
                    MockOfferInteractor.sampleOffer1,
                    MockOfferInteractor.sampleOffer1,
                    MockOfferInteractor.sampleOffer1,
                    MockOfferInteractor.sampleOffer1,
                ]
            ) { offer in
                ListingOfferRow(offer: offer)
            }
        }
        .previewDisplayName("Light mode")
        .environmentObject(Navigator.init(initialPath: "/"))
        .environmentObject(DIContainer.mock)
        .previewInterfaceOrientation(.portrait)
        
        NavigableView() {
            Text("Hello")
        }
        .previewDisplayName("Dark mode")
        .preferredColorScheme(.dark)
        .environmentObject(Navigator.init(initialPath: "/"))
        .environmentObject(DIContainer.mock)
    }
}
