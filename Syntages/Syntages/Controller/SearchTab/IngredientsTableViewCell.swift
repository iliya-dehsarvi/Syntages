//
//  IngredientsTableViewCell.swift
//  Syntages
//
//  Created by Iliya dehsarvi on 7/22/21.
//

import UIKit

class IngredientsTableViewCell: UITableViewCell {
	
	@IBOutlet weak var imageBackground: UIView!
	@IBOutlet weak var ingredientName: UILabel!
	@IBOutlet weak var drinkSuggestionsCollectionView: UICollectionView!
	
	var drinks: [Drink] = []
	var alcoholTypeApiProcessor = AlcoholTypeApiProcessor()
	
	override func awakeFromNib() {
		super.awakeFromNib()
		self.drinkSuggestionsCollectionView.register(UINib(nibName:"DrinksCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DrinksCollectionViewCellID")
		imageBackground.layer.cornerRadius = 20
		imageBackground.layer.masksToBounds = true
		drinkSuggestionsCollectionView.delegate = self
		drinkSuggestionsCollectionView.dataSource = self
		if let alcoholType = ingredientName.text {
			self.alcoholTypeApiProcessor.fetchCocktails(alcoholName: alcoholType)
		}
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}
	
	@IBAction func seeAllTapped(_ sender: UIButton) {
		print("See All button was tapped for\(ingredientName.text!)")
	}
}

//MARK: - UICollectionViewDelegate
extension IngredientsTableViewCell: UICollectionViewDelegate {
	
}

//MARK: - UICollectionViewDataSource
extension IngredientsTableViewCell: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return 5
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DrinksCollectionViewCellID", for: indexPath as IndexPath) as! DrinksCollectionViewCell
		
		
		
		return cell
	}
}

//MARK: - AlcoholTypeDrinksDelegate
extension IngredientsTableViewCell: AlcoholTypeDrinksDelegate {
	func didUpdateCocktailes(_ alcoholTypeApiProcessor: AlcoholTypeApiProcessor, drinks: [Drink]) {
		DispatchQueue.main.async {
			self.drinks = drinks
			self.drinkSuggestionsCollectionView.reloadData()
		}
	}
	
	func didFailWithError(error: Error) {
		DispatchQueue.main.async {
//			let drink = Drink(strDrink: "No results found.", strDrinkThumb: "", idDrink: "")
//			self.drinks = [drink]
//			self.drinkSuggestionsCollectionView.reloadData()
			print(error)
			
		}
	}
}

