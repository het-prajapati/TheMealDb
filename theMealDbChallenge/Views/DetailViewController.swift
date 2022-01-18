//
//  DetailViewController.swift
//  theMealDbChallenge
//
//  Created by Het Prajapati on 1/18/22.
//

import Foundation
import UIKit


class DetailViewController: UIViewController {
    
    @IBOutlet weak var detailsImageView: UIImageView!
    @IBOutlet weak var mealNameLabel: UILabel!
    @IBOutlet weak var ingredientsLabel: UILabel!
    @IBOutlet weak var instructionsMeasurementLabel: UILabel!
    
    var details = [MealDetails]()
    var mealID: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.detailsImageView.isHidden = true
        self.mealNameLabel.isHidden = true
        self.ingredientsLabel.isHidden = true
        self.instructionsMeasurementLabel.isHidden = true
        
        // Making sure to not exceed lines
        mealNameLabel.numberOfLines = 0
        instructionsMeasurementLabel.numberOfLines = 0
        ingredientsLabel.numberOfLines = 0
        
        // Corner Radius for the Image View
        detailsImageView.layer.cornerRadius = 10
        detailsImageView.clipsToBounds = true
        
        // API Call
        APIHandler.shared.downloadMealDetails(for: mealID) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let meal):
                self.detailsInfo(meal: meal)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        // Title for the ViewController
        self.title = "Details"
    }
    
    
    // Adding the Data onto the table view
    func detailsInfo(meal: MealDetailsData) {
        
        let ingredientsTitle: String = "Ingredients & Measurements"
        
        DispatchQueue.main.async {
            self.details = meal.meals
            self.downloadingImage(fromURL: self.details.first?.strMealThumb ?? "No Thumbnail Found")
            self.mealNameLabel.text = self.details.first?.strMeal
            
            var fetchIngredients =
                """
                \(ingredientsTitle)\n
                \(self.details.first?.strIngredient1 ?? "")  \(self.details.first?.strMeasure1 ?? "")\n \
                \(self.details.first?.strIngredient2 ?? "")  \(self.details.first?.strMeasure2 ?? "")\n \
                \(self.details.first?.strIngredient3 ?? "")  \(self.details.first?.strMeasure3 ?? "")\n \
                \(self.details.first?.strIngredient4 ?? "")  \(self.details.first?.strMeasure4 ?? "")\n \
                \(self.details.first?.strIngredient5 ?? "")  \(self.details.first?.strMeasure5 ?? "")\n \
                \(self.details.first?.strIngredient6 ?? "")  \(self.details.first?.strMeasure6 ?? "")\n \
                \(self.details.first?.strIngredient7 ?? "")  \(self.details.first?.strMeasure7 ?? "")\n \
                \(self.details.first?.strIngredient8 ?? "")  \(self.details.first?.strMeasure8 ?? "")\n \
                \(self.details.first?.strIngredient9 ?? "")  \(self.details.first?.strMeasure9 ?? "")\n \
                \(self.details.first?.strIngredient10 ?? "")  \(self.details.first?.strMeasure10 ?? "")\n \
                \(self.details.first?.strIngredient11 ?? "")  \(self.details.first?.strMeasure11 ?? "")\n \
                \(self.details.first?.strIngredient12 ?? "")  \(self.details.first?.strMeasure12 ?? "")\n \
                \(self.details.first?.strIngredient13 ?? "")  \(self.details.first?.strMeasure13 ?? "")\n \
                \(self.details.first?.strIngredient14 ?? "")  \(self.details.first?.strMeasure14 ?? "")\n \
                \(self.details.first?.strIngredient15 ?? "")  \(self.details.first?.strMeasure15 ?? "")\n \
                \(self.details.first?.strIngredient16 ?? "")  \(self.details.first?.strMeasure16 ?? "")\n \
                \(self.details.first?.strIngredient17 ?? "")  \(self.details.first?.strMeasure17 ?? "")\n \
                \(self.details.first?.strIngredient18 ?? "")  \(self.details.first?.strMeasure18 ?? "")\n \
                \(self.details.first?.strIngredient19 ?? "")  \(self.details.first?.strMeasure19 ?? "")\n \
                \(self.details.first?.strIngredient20 ?? "")  \(self.details.first?.strMeasure20 ?? "")
                """.replacingOccurrences(of: " ,", with: "").trimmingCharacters(in: .whitespacesAndNewlines)
            
            if fetchIngredients.last == "," {
                _ = fetchIngredients.popLast()
            }
            
            self.instructionsMeasurementLabel.text =
             """
             Instructions\n
             \(self.details.first?.strInstructions ?? "")
             """
            
            self.ingredientsLabel.text = fetchIngredients
            self.ingredientsLabel.font = UIFont.systemFont(ofSize: 22, weight: .medium)
            self.detailsImageView.isHidden = false
            self.mealNameLabel.isHidden = false
            self.instructionsMeasurementLabel.isHidden = false
            self.ingredientsLabel.isHidden = false
        }
    }
    
    // MARK: - Downloading Image
    func downloadingImage(fromURL url: String) {
        APIHandler.shared.downloadingImage(from: url) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.detailsImageView.image = image
            }
        }
    }
}
