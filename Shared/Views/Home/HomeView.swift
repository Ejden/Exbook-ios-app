//
//  HomeView.swift
//  Exbook
//
//  Created by Adrian Stypinski on 18/07/2022.
//

import SwiftUI
import SwiftUIRouter

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel = HomeViewModel()
    @EnvironmentObject var navigator: Navigator
    
    var body: some View {
        NavigableView {
            VStack {
                Text("Home View")
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: HomeViewModel.testInstance())
    }
}
