//
//  CategoryViewController.swift
//  theMealDbChallenge
//
//  Created by Het Prajapati on 1/15/22.
//

import UIKit

class CategoryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
     var categories = [Category]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let nib = UINib(nibName: CategoryTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: CategoryTableViewCell.identifier)
        
        APIHandler.shared.downloadCategoriesJSON() { [weak self] result in
            guard let self = self else { return }
            
            switch result {
                
            case .success(let categories):
                self.updateUI(with: categories)
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    func updateUI(with categories: CategoriesData) {
        
        DispatchQueue.main.async {
            self.categories = categories.categories
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
    }
    
}

// Table View for the CategoryViewController
extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let categoryModel  = categories[indexPath.row]
        let viewController = MealViewController.instantiate()
        viewController.category = categoryModel.strCategory
        viewController.title    = categoryModel.strCategory + " Meals"
        navigationController?.pushViewController(viewController, animated: true)
        print("\(categories[indexPath.row].strCategory) Selected")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.identifier, for: indexPath) as! CategoryTableViewCell
        cell.initializing(category: categories[indexPath.row])
        categories.sort{ $0.strCategory < $1.strCategory }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {

  
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}


 
