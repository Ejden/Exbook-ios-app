//
//  SearchBar.swift
//  Exbook
//
//  Created by Adrian Stypinski on 18/07/2022.
//

import SwiftUI

struct SearchBarButton: View {
    var body: some View {
        Text("Szukaj")
            .frame(maxWidth: .infinity, minHeight: 30)
            .overlay(
                RoundedRectangle(cornerRadius: StandardUI.Spacing.extraSmall)
                    .stroke(.gray)
            )
    }
}

struct SearchBarButton_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarButton()
    }
}
