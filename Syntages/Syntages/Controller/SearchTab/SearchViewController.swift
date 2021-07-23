//
//  SearchViewController.swift
//  Syntages
//
//  Created by Iliya dehsarvi on 7/19/21.
//

import UIKit

//MARK: - SearchViewController
class SearchViewController: UIViewController {
	//MARK: - @IBOutlets
	@IBOutlet weak var historyTableView: UITableView!
	@IBOutlet weak var seachBar: UISearchBar!
	//MARK: - Variables
	var alcoholTypeApiProcessor = AlcoholTypeApiProcessor()
	var ingredients: [Ingredient] = []
//	var searchHistory: [Drink] = []
	//MARK: - Methods
	override func viewDidLoad() {
		super.viewDidLoad()
		self.historyTableView.register(UINib(nibName: "IngredientsTableViewCell", bundle: nil), forCellReuseIdentifier: "IngredientsTableViewCellID")
		self.historyTableView.delegate = self
		self.historyTableView.dataSource = self
		self.seachBar.delegate = self
//		self.alcoholTypeApiProcessor.delegate = self
	}
}
//MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate { }
//MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.ingredients.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath) as UITableViewCell
		
		
		
//		cell.textLabel?.text = ingredients[indexPath.row].strDrink
//			if let stringURL = URL(string: ingredients[indexPath.row].strDrinkThumb) {
//				cell.imageView?.load(url: stringURL)
//				cell.imageView?.layer.cornerRadius = (cell.imageView?.frame.size.width ?? 0.0) / 2
//				cell.imageView?.layer.masksToBounds = true
//			}
		
		return cell
	}
}
//MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//		self.ingredients = self.searchHistory.reversed()
		self.historyTableView.reloadData()
	}
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//		print(searchBar.text!)
//		if let alcoholType = searchBar.text {
//			self.alcoholTypeApiProcessor.fetchCocktails(alcoholName: alcoholType)
//			let lastSearchEntry = Drink(strDrink: alcoholType, strDrinkThumb: "", idDrink: "")
//			self.searchHistory.append(lastSearchEntry)
//		}
		searchBar.endEditing(true)
//		print(drinks.count)
//		self.historyTableView.reloadData()
	}
}

////MARK: - AlcoholTypeDrinksDelegate
//extension SearchViewController: AlcoholTypeDrinksDelegate {
//	func didUpdateCocktailes(_ alcoholTypeApiProcessor: AlcoholTypeApiProcessor, drinks: [Drink]) {
//		DispatchQueue.main.async {
//			self.drinks = drinks
//			self.historyTableView.reloadData()
//		}
//	}
//
//	func didFailWithError(error: Error) {
//		DispatchQueue.main.async {
//			let drink = Drink(strDrink: "No results found.", strDrinkThumb: "", idDrink: "")
//			self.drinks = [drink]
//			self.historyTableView.reloadData()
//			print(error)
//
//		}
//	}
//}

extension UIImageView {
    func load(url: URL) {
	   DispatchQueue.global().async { [weak self] in
		  if let data = try? Data(contentsOf: url) {
			 if let image = UIImage(data: data) {
				DispatchQueue.main.async {
					self?.image = image
				}
			 }
		  }
	   }
    }
}
