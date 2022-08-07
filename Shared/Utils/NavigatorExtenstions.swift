//
//  NavigatorExtenstions.swift
//  Exbook
//
//  Created by Adrian Stypinski on 02/08/2022.
//

import SwiftUIRouter

extension Navigator {
    func navigate(_ path: Path) {
        navigate(path.raw)
    }
}
