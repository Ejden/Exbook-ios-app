//
//  LoadableImage.swift
//  Exbook
//
//  Created by Adrian Stypinski on 06/08/2022.
//

import OSLog
import SwiftUI

private let logger = Logger()

struct LoadableImage: View {
    let rawImage: RawImage
    let placeholder: PlaceholderStyle
    let width: CGFloat?
    let height: CGFloat?
    let maxWidth: CGFloat?
    let maxHeight: CGFloat?
    
    @EnvironmentObject var container: DIContainer
    @State private var image: Loadable<UIImage> = .loading
    private let cornerRadius: CGFloat = 10
    
    init(image: RawImage, placeholder: PlaceholderStyle = .image, width: CGFloat, height: CGFloat, maxWidth: CGFloat? = nil, maxHeight: CGFloat? = nil) {
        self.rawImage = image
        self.placeholder = placeholder
        self.width = width
        self.height = height
        self.maxWidth = width
        self.maxHeight = width
    }
    
    init(image: RawImage, placeholder: PlaceholderStyle = .image, maxWidth: CGFloat?, maxHeight: CGFloat?) {
        self.rawImage = image
        self.placeholder = placeholder
        self.width = nil
        self.height = nil
        self.maxWidth = maxWidth
        self.maxHeight = maxHeight
    }
    
    var body: some View {
        Group {
            switch image {
            case .loading: renderPlaceholder()
            case let .loaded(loadedImage): renderImage(loadedImage)
            case .failed: placeholderImage
            }
        }
        .onAppear {
            logger.debug("Loading img with path: \(rawImage.url.path)")
            container.interactors.imagesInteractor.load(bind: $image, image: self.rawImage)
        }
    }
    
    func renderImage(_ uiImage: UIImage) -> some View {
        Group {
            if let width = width {
                Image(uiImage: uiImage)
                    .resizable()
                    .frame(width: width, height: self.height, alignment: .leading)
                    .cornerRadius(self.cornerRadius)
            } else {
                Image(uiImage: uiImage)
                    .resizable()
                    .frame(maxWidth: self.maxWidth, maxHeight: self.maxHeight, alignment: .leading)
                    .cornerRadius(self.cornerRadius)
            }
        }
    }
    
    func renderPlaceholder() -> some View {
        Group {
            switch placeholder {
            case .image: placeholderImage
            case .loader: placeholderLoader
            case .empty: placeholderEmpty
            }
        }
    }
    
    var placeholderImage: some View {
        Group {
            if let width = width {
                Image(systemName: "photo")
                    .resizable()
                    .frame(width: width, height: self.height, alignment: .leading)
                    .cornerRadius(self.cornerRadius)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .frame(maxWidth: self.maxWidth, maxHeight: self.maxHeight, alignment: .leading)
                    .cornerRadius(self.cornerRadius)
            }
        }
    }
    
    var placeholderEmpty: some View {
        EmptyView()
            .frame(width: self.width, height: self.height, alignment: .leading)
    }
    
    var placeholderLoader: some View {
        ProgressView()
            .frame(width: self.width, height: self.height, alignment: .leading)
    }
}

enum PlaceholderStyle {
    case image
    case loader
    case empty
}

struct LoadableImage_Previews: PreviewProvider {
    static var previews: some View {
        LoadableImage(
            image: MockOfferInteractor.sampleOffer1.images.thumbnail,
            placeholder: .image,
            width: 120,
            height: 90
        )
            .environmentObject(DIContainer.mock)
    }
}
