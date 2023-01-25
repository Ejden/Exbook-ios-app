//
//  PageResponse.swift
//  Exbook
//
//  Created by Adrian Stypinski on 17/09/2022.
//

import Foundation

struct PageResponse<T : Decodable> : Decodable {
    let content: Array<T>
    let pageable: Pageable
    let totalPages: Int
}

extension PageResponse {
    struct Pageable : Decodable {
        let offset: Int
        let pageNumber: Int
        let pageSize: Int
        let paged: Bool
        let sort: Sort
        let unpaged: Bool
    }
}

extension PageResponse {
    struct Sort : Decodable {
        let empty: Bool
        let sorted: Bool
        let unsorted: Bool
    }
}
