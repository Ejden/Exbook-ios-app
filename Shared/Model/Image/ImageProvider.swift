//
//  ImageProvider.swift
//  Exbook
//
//  Created by Adrian Stypinski on 23/07/2022.
//

import Foundation
import Combine
import UIKit

protocol ImageProvider {
    func fetchImage(url: URL) -> AnyPublisher<UIImage, Error>
}

class RealImageProvider {
    
}
