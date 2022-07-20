//
//  HomeViewModel.swift
//  Exbook
//
//  Created by Adrian Stypinski on 18/07/2022.
//

import Foundation

class HomeViewModel: ObservableObject {
    static func initialize() -> HomeViewModel {
        return HomeViewModel()
    }
    
    public static func testInstance() -> HomeViewModel {
        return HomeViewModel()
    }
}
