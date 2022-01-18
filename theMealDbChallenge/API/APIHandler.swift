//
//  APIHandler.swift
//  theMealDbChallenge
//
//  Created by Het Prajapati on 1/17/22.
//

import Foundation
import UIKit


// MARK: - APIHandler
class APIHandler {
    
    private let commonURL = "https://www.themealdb.com/api/json/v1/1/"
    static let shared = APIHandler()
    private let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    // MARK: - Fetching All Categories by decodinng JSON
    func downloadCategoriesJSON(completed: @escaping (Result<CategoriesData, Errors>) -> Void) {
        
        let categoriesURL = commonURL + "categories.php"
        
        guard let url = URL(string: categoriesURL) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, urlResponse, error in
            
            guard let data = data, error == nil, urlResponse != nil else {
                print("Something is wrong!")
                return
            }
            print("Downloaded Categories")
            
            do {
                let decoder = JSONDecoder()
                let downloadedCategories = try decoder.decode(CategoriesData.self, from: data)
                completed(.success(downloadedCategories))
            }
            catch {
                print(error.localizedDescription)
                print("Error Parsing Categories JSON")
            }
        }
        task.resume()
        
    }
    
    
    // MARK: - Fetching All Meals by decoding JSON
    func downloadMealsJSON(for category: String, completed: @escaping (Result<MealData, Errors>) -> Void) {
        
        let mealsURL = commonURL + "filter.php?c=\(category)"
        
        guard let url = URL(string: mealsURL) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, urlResponse, error in
            
            guard let data = data, error == nil, urlResponse != nil else {
                print("Something is wrong!")
                return
            }
            print("Downloaded Meals")
            
            do {
                let decoder = JSONDecoder()
                let downloadedMeals = try decoder.decode(MealData.self, from: data)
                completed(.success(downloadedMeals))
            }
            catch {
                print("Error Parsing Meals JSON")
            }
            
        }
        task.resume()
    }
    
    //MARK: - Fetching Meal Details by decoding JSON
    func downloadMealDetails(for mealID: String, completed: @escaping (Result<MealDetailsData, Errors>) -> Void) {
        
        let mealDetailsURL = commonURL + "lookup.php?i=\(mealID)"
        
        guard let url = URL(string: mealDetailsURL) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, urlResponse, error in
            
            guard let data = data, error == nil, urlResponse != nil else {
                print("Something is wrong!")
                return
            }
            print("Downloaded Meal Details")
            
            do {
                let decoder = JSONDecoder()
                let downloadedMealDetails = try decoder.decode(MealDetailsData.self, from: data)
                completed(.success(downloadedMealDetails))
            }
            catch {
                print("Error Parsing Meal Details JSON")
            }
            
        }
        task.resume()
    }
    
    
    // MARK: - Downloading Image and Caching
    func downloadingImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {
        
        // To Check if Image is Cached or not
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            completed(image)
            return
        }
        
        guard let url = URL(string: urlString) else {
            completed(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            guard let self = self,
                error == nil,
                let response = response as? HTTPURLResponse, response.statusCode == 200,
                let data = data,
                let image = UIImage(data: data) else {
                    completed(nil)
                    return
                }
            
            // Inserting Image into the Cache
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        task.resume()
    }
    
    
}
