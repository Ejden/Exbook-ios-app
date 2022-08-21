//
//  OfferOtherRecommendations.swift
//  Exbook
//
//  Created by Adrian Stypinski on 21/08/2022.
//

import SwiftUI

struct OfferOtherRecommendations: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Inne oferty użytkownika")
                .font(.title3)
            Divider()
            Text("Ten użytkownik nie posiada więcej ofert.")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct OfferOtherRecommendations_Previews: PreviewProvider {
    static var previews: some View {
        OfferOtherRecommendations()
    }
}
