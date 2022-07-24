//
//  SearchBar.swift
//  Exbook
//
//  Created by Adrian Stypinski on 22/07/2022.
//

import SwiftUI

struct ListingSearchBar: View {
    @Binding var searchingPhrase: String
    @State private var providedText: String = ""
    @State private var filterSheetVisible: Bool = false
    
    var body: some View {
        HStack {
            searchBar
            filterButton
        }
        .sheet(isPresented: $filterSheetVisible) {
            Text("Filtry")
        }
    }
    
    @ViewBuilder private var searchBar: some View {
        TextField(text: $providedText) {
            Text("Znajdź")
        }
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .onSubmit {
            searchingPhrase = providedText
        }
    }
    
    @ViewBuilder private var filterButton: some View {
        Button {
            filterSheetVisible.toggle()
        } label: {
            Image(systemName: "slider.horizontal.3")
                .frame(width: 32, height: 32, alignment: .center)
        }
    }
}

struct ListingSearchBar_Previews: PreviewProvider {
    @State private static var text: String = ""
    
    static var previews: some View {
        ListingSearchBar(searchingPhrase: $text)
    }
}
