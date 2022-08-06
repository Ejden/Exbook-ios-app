//
//  HomeView.swift
//  Exbook
//
//  Created by Adrian Stypinski on 18/07/2022.
//

import SwiftUI
import SwiftUIRouter

struct HomeView: View {
    @EnvironmentObject var navigator: Navigator
    
    var body: some View {
        NavigableView {
            ScrollView {
                VStack {
                    SearchBarButton()
                        .padding()
                        .onTapGesture {
                            navigator.navigate(.listing)
                        }
                    RecommendedOffers()
                }
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(Navigator.init())
            .environmentObject(DIContainer.mock)
    }
}
