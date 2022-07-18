//
//  ContentView.swift
//  Shared
//
//  Created by Adrian Stypinski on 18/07/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    MainTabItem(name: "Home", icon: "house.fill")
                }
            ListingView()
                .tabItem {
                    MainTabItem(name: "Search", icon: "magnifyingglass")
                }
            BasketView()
                .tabItem {
                    MainTabItem(name: "Basket", icon: "cart.fill")
                }
            AccountView()
                .tabItem {
                    MainTabItem(name: "Account", icon: "person.fill")
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
