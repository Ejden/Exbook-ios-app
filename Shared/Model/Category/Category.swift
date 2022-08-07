//
//  Category.swift
//  Exbook
//
//  Created by Adrian Stypinski on 22/07/2022.
//

import Foundation

public struct CategoryId: Hashable {
    let raw: String
}

public struct Category: Identifiable {
    public let id: CategoryId
    public let name: String
    public let parentId: CategoryId?
}
