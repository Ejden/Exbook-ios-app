//
//  RawImageResponse.swift
//  Exbook
//
//  Created by Adrian Stypinski on 17/09/2022.
//

import Foundation

struct RawImageResponse : Decodable {
    let url: String
    
    func toDomain() -> RawImage {
        return RawImage(url: URL(string: url)!)
    }
}
