//
//  StarsCounter.swift
//  Exbook
//
//  Created by Adrian Stypinski on 07/08/2022.
//

import SwiftUI

struct StarsCounter: View {
    private let filledStars: Int
    private let halfFilledStarts: Int
    private let emptyStars: Int
    
    init(stars: Double) {
        let wholeStars = Int(stars > 5 ? 5 : stars)
        let rest = (stars > 5 ? 5 : stars) - Double(wholeStars)
        
        self.filledStars = wholeStars
        self.halfFilledStarts = rest > 0.4 ? 1 : 0
        self.emptyStars = 5 - self.filledStars - self.halfFilledStarts
    }
    
    var body: some View {
        HStack {
            ForEach(0..<filledStars) { _ in
                Image(systemName: "star.fill")
                    .resizable()
                    .frame(width: StandardUI.Spacing.small, height: StandardUI.Spacing.small)
            }
            ForEach(0..<halfFilledStarts) { _ in
                Image(systemName: "star.leadinghalf.filled")
                    .resizable()
                    .frame(width: StandardUI.Spacing.small, height: StandardUI.Spacing.small)
            }
            ForEach(0..<emptyStars) { _ in
                Image(systemName: "star")
                    .resizable()
                    .frame(width: StandardUI.Spacing.small, height: StandardUI.Spacing.small)
            }
        }
    }
}

struct StarsCounter_Previews: PreviewProvider {
    static var previews: some View {
        StarsCounter(stars: 0)
    }
}
