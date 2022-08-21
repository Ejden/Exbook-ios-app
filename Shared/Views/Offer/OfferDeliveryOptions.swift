//
//  OfferDeliveryOptions.swift
//  Exbook
//
//  Created by Adrian Stypinski on 21/08/2022.
//

import SwiftUI

struct OfferDeliveryOptions: View {
    let offer: DetailedOffer
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Sposób dostawy")
                .font(.title3)
            Divider()
            HStack {
                Text("Nazwa")
                Spacer()
                Text("Cena")
            }
            Divider()
            ForEach(offer.shipping.shippingMethods) { shippingMethod in
                HStack {
                    Text(shippingMethod.name)
                    Spacer()
                    PriceSnippet(shippingMethod.price)
                }
                Divider()
            }
        }
    }
}

struct OfferDeliveryOptions_Previews: PreviewProvider {
    static var previews: some View {
        OfferDeliveryOptions(offer: MockOfferInteractor.sampleDetailsOffer)
    }
}
