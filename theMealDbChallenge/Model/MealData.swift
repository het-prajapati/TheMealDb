//
//  MealData.swift
//  theMealDbChallenge
//
//  Created by Het Prajapati on 1/15/22.
//

import Foundation

//MARK: - MealData
struct MealData: Codable {
    let meals: [Meal]
    
    init (meals: [Meal]) {
        self.meals = meals
    }
}

//MARK: - Meal
struct Meal: Codable {
    
    let idMeal: String
    let strMeal: String
    let strMealThumb: String

    init(idMeal: String, strMeal: String, strMealThumb: String) {
        self.idMeal = idMeal
        self.strMeal = strMeal
        self.strMealThumb = strMealThumb
    }
}
