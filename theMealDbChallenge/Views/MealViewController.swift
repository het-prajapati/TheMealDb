//
//  DetailViewController.swift
//  theMealDbChallenge
//
//  Created by Het Prajapati on 1/15/22.
//

import UIKit

class MealViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var meal = [Meal]()
    var category: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: MealTableViewCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: MealTableViewCell.identifier)
        
        APIHandler.shared.downloadMealsJSON(for: category) { [weak self] result in
            
            guard let self = self else { return }
            
            switch result {
            case .success(let meals): self.updateUI(with: meals)
                
            case .failure(let error): print(error.localizedDescription)
        }
    }
}
    
    func updateUI(with subcategory: MealData) {
        DispatchQueue.main.async {
            self.meal = subcategory.meals
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
    }
}

//Table View for the MealViewController

extension MealViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let categoryModel = meal[indexPath.row]
        let viewController  = DetailViewController.instantiate()
        viewController.mealID = categoryModel.idMeal
        navigationController?.pushViewController(viewController, animated: true)
        print("\(meal[indexPath.row].strMeal) Selected")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meal.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MealTableViewCell.identifier, for: indexPath) as! MealTableViewCell
        
        cell.initializing(meal: meal[indexPath.row])
        // Sorting Alphabetically
        meal.sort{ $0.strMeal < $1.strMeal}
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
