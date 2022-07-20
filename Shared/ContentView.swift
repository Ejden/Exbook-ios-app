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
        }
    }
}

struct MainTabItem: View {
    let name: String
    let icon: String
    
    var body: some View {
        VStack {
            Image(systemName: icon)
            Text(name)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDisplayName("Light mode")
        ContentView()
            .preferredColorScheme(.dark)
            .previewDisplayName("Dark mode")
    }
}
