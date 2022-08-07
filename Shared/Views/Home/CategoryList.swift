//
//  CategoryList.swift
//  Exbook
//
//  Created by Adrian Stypinski on 07/08/2022.
//

import SwiftUI
import SwiftUIRouter

struct CategoryList: View {
    @EnvironmentObject private var container: DIContainer
    @EnvironmentObject private var navigator: Navigator
    @State private var categories: Loadable<Array<Category>> = .loading
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Kategorie")
                .font(.title2)
                .frame(maxWidth: .infinity, alignment: .leading)
            switch categories {
            case .loading: lodadingView
            case let .loaded(loadedCategories): categoryList(loadedCategories)
            case .failed: errorView
            }
        }
        .frame(maxWidth: .infinity)
        .onAppear {
            container.interactors.categoryInteractor.fetchCategoryList($categories)
        }
    }
    
    private var errorView: some View = Text("Error")
    
    private var lodadingView: some View = HStack {
        Spacer()
        ProgressView()
        Spacer()
    }
    
    private func categoryList(_ loadedCategories: Array<Category>) -> some View {
        ForEach(loadedCategories) { category in
            Text(category.name)
        }
    }
}

struct CategoryListItem: View {
    let category: Category
    
    var body: some View {
        Text(category.name)
    }
}

struct CategoryList_Previews: PreviewProvider {
    static var previews: some View {
        CategoryList()
            .environmentObject(DIContainer.mock)
            .environmentObject(Navigator.init())
    }
}
