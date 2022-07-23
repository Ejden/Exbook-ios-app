//
//  SearchBar.swift
//  Exbook
//
//  Created by Adrian Stypinski on 22/07/2022.
//

import SwiftUI

struct ListingSearchBar: View {
    @State var searchingPhrase: String = ""
    
    var body: some View {
        TextField(text: $searchingPhrase) {
            Text("Znajdź")
        }
        .padding(.all, StandardUI.Spacing.small)
        .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}

struct ListingSearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar()
    }
}
