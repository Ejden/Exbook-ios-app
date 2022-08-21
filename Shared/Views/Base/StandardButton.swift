//
//  StandardButton.swift
//  Exbook
//
//  Created by Adrian Stypinski on 21/08/2022.
//

import SwiftUI

struct StandardButton: View {
    let type: ButtonType
    let text: String
    let action: () -> Void
    
    var body: some View {
        Group {
            switch type {
            case .primary: primaryButton()
            case .secondary: secondaryButton()
            }
        }
    }
    
    @ViewBuilder private func primaryButton() -> some View {
        Button {
            action()
        } label: {
            HStack {
                Spacer()
                Text(text)
                    .font(.headline)
                    .foregroundColor(StandardUI.Color.white)
                    .padding(StandardUI.Spacing.small)
                Spacer()
            }
            .background(StandardUI.Color.primaryBlue)
            .cornerRadius(4)
        }

    }
    
    @ViewBuilder private func secondaryButton() -> some View {
        Button {
            action()
        } label: {
            HStack {
                Spacer()
                Text(text)
                    .font(.headline)
                    .foregroundColor(StandardUI.Color.primaryBlue)
                    .padding(StandardUI.Spacing.small)
                Spacer()
            }
            .cornerRadius(4)
        }
    }
}

enum ButtonType {
    case primary
    case secondary
}

struct StandardButton_Previews: PreviewProvider {
    static var previews: some View {
        StandardButton(type: .primary, text: "Kup") {}
        StandardButton(type: .secondary, text: "Wymień") {}
    }
}
