//
//  CategoryTableViewCell.swift
//  theMealDbChallenge
//
//  Created by Het Prajapati on 1/17/22.
//

import Foundation
import UIKit

class CategoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryImageView: UIImageView!
    
    // Storyboard Use
    static let identifier = "CategoryTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func initializing(category: Category) {
        categoryLabel.text =  category.strCategory
        downloadingImage(fromURL: category.strCategoryThumb)
    }
    
    // Resuse Prep
    override func prepareForReuse() {
        categoryImageView.image = nil
        categoryLabel.text = ""
    }

  // Fetches the Image from the URL for the Cell
    func downloadingImage(fromURL url: String) {
        APIHandler.shared.downloadingImage(from: url) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.categoryImageView.image = image
            }
        }
    }
    
    
}
