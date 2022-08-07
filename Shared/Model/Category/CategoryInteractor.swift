//
//  CategoryInteractor.swift
//  Exbook
//
//  Created by Adrian Stypinski on 07/08/2022.
//

import Foundation

protocol CategoryInteractor {
    func fetchCategoryList(_ bind: LoadableBind<Array<Category>>)
}

class RealCategoryInteractor: CategoryInteractor {
    func fetchCategoryList(_ bind: LoadableBind<Array<Category>>) {
        bind.wrappedValue = .loaded([MockCategoryInteractor.category1, MockCategoryInteractor.category2, MockCategoryInteractor.category3])
    }
}

class MockCategoryInteractor: CategoryInteractor {
    public static let category1 = Category(id: CategoryId(raw: "category-1"), name: "Dramat", parentId: nil)
    public static let category2 = Category(id: CategoryId(raw: "category-2"), name: "Akcja", parentId: nil)
    public static let category3 = Category(id: CategoryId(raw: "category-3"), name: "Sci-Fi", parentId: CategoryId(raw: "category-2"))
    
    func fetchCategoryList(_ bind: LoadableBind<Array<Category>>) {
        bind.wrappedValue = .loaded([Self.category1, Self.category2, Self.category3])
    }
}
