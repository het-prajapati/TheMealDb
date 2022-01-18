//
//  CategoriesData.swift
//  theMealDbChallenge
//
//  Created by Het Prajapati on 1/15/22.
//

import Foundation

// MARK: - CategoriesData
struct CategoriesData: Codable {
    let categories: [Category]
    
    init(categories: [Category]) {
        self.categories = categories
    }
}

// MARK: - Category
struct Category: Codable {
    let idCategory, strCategory: String
    let strCategoryThumb: String
    let strCategoryDescription: String
    
    init(idCategory: String, strCategory: String, strCategoryThumb: String, strCategoryDescription: String) {
        self.idCategory = idCategory
        self.strCategory = strCategory
        self.strCategoryThumb = strCategoryThumb
        self.strCategoryDescription = strCategoryDescription
    }
}
