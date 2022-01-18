//
//  MealTableViewCell.swift
//  theMealDbChallenge
//
//  Created by Het Prajapati on 1/17/22.
//

import Foundation
import UIKit


class MealTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var mealLabel: UILabel!
    @IBOutlet weak var mealImageView: UIImageView!
    
    // Storyboard Use
    static let identifier = "MealTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func initializing(meal: Meal) {
        mealLabel.text = meal.strMeal
        downloadingImage(fromURL: meal.strMealThumb)
    }
    
    // Resuse Prep
    override func prepareForReuse() {
        mealImageView.image = nil
        mealLabel.text = ""
    }
    
  // Fetches the Image from the URL for the Cell
    func downloadingImage(fromURL url: String) {
        APIHandler.shared.downloadingImage(from: url) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.mealImageView.image = image
                self.mealImageView.layer.cornerRadius = 28
                self.mealImageView.clipsToBounds = true
            }
        }
    }
}
