//
//  ImagesInteractor.swift
//  Exbook
//
//  Created by Adrian Stypinski on 23/07/2022.
//

import Foundation
import SwiftUI

protocol ImagesInteractor {
    func load(bind: Binding<UIImage>, image: RawImage)
}

class RealImagesInteractor: ImagesInteractor {
    let imageProvider: ImageProvider
    
    init(imageProvider: ImageProvider) {
        self.imageProvider = imageProvider
    }
    
    func load(bind: Binding<UIImage>, image: RawImage) {
        imageProvider.fetchImage(url: image.url)
            .sink { completion in
                if let error = completion.error {
                    print(error)
                }
            } receiveValue: { result in
                bind.wrappedValue = result
            }
    }
}

class MockImagesInteractor: ImagesInteractor {
    func load(bind: Binding<UIImage>, image: RawImage) {
        
    }
}
