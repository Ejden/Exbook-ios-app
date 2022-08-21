//
//  OfferDescription.swift
//  Exbook
//
//  Created by Adrian Stypinski on 21/08/2022.
//

import SwiftUI
import ExpandableText

struct OfferDescription: View {
    let offer: DetailedOffer
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Opis")
                .font(.title3)
            Divider()
            ExpandableText(text: offer.description)
                .lineLimit(4)
        }
    }
}

struct OfferDescription_Previews: PreviewProvider {
    static var previews: some View {
        OfferDescription(offer: MockOfferInteractor.sampleDetailsOffer)
    }
}
