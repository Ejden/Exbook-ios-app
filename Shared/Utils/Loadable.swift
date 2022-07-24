//
//  Loadable.swift
//  Exbook
//
//  Created by Adrian Stypinski on 24/07/2022.
//

import Foundation

enum Loadable<T> {
    case loading
    case loaded(T)
    case failed(Error)
    
    var value: T? {
        switch self {
        case let .loaded(value): return value
        default: return nil
        }
    }
    
    var error: Error? {
        switch self {
        case let .failed(error): return error
        default: return nil
        }
    }
    
    mutating func setLoaded(value: T) {
        self = .loaded(value)
    }
    
    mutating func setFailed(error: Error) {
        self = .failed(error)
    }
}

extension Loadable: Equatable where T: Equatable {
    static func == (lhs: Loadable<T>, rhs: Loadable<T>) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading): return true
        case let (.loaded(lhsV), .loaded(rhsV)): return lhsV == rhsV
        case let (.failed(lhsE), .failed(rhsE)): return lhsE.localizedDescription == rhsE.localizedDescription
        default: return false
        }
    }
}
