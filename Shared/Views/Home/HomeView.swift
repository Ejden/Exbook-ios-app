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
        MainView {
            ScrollView {
                VStack {
                    SearchBarButton()
                        .padding()
                        .background(StandardUI.Color.desk)
                        .onTapGesture {
                            navigator.navigate(.listing)
                        }
                    RecommendedOffers()
                        .background(StandardUI.Color.desk)
                    CategoryList()
                        .padding()
                        .background(StandardUI.Color.desk)
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
