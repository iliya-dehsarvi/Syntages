//
//  IngredientsTableViewCell.swift
//  Syntages
//
//  Created by Iliya dehsarvi on 7/22/21.
//

import UIKit

class IngredientsTableViewCell: UITableViewCell {
	
	@IBOutlet weak var imageBackground: UIView!
	@IBOutlet weak var inegredientImage: UIImageView!
	@IBOutlet weak var ingredientName: UILabel!
	@IBOutlet weak var drinkSuggestionsCollectionView: UICollectionView!
	
	var drinks: [Drink] = []
	var alcoholTypeApiProcessor = AlcoholTypeApiProcessor()
	
	override func awakeFromNib() {
		super.awakeFromNib()
		self.drinkSuggestionsCollectionView.register(UINib(nibName:"DrinksCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "DrinksCollectionViewCellID")
		imageBackground.layer.cornerRadius = 20
		imageBackground.layer.masksToBounds = true
		imageBackground.layer.borderWidth = 1
		imageBackground.layer.borderColor = UIColor.systemPurple.cgColor
		drinkSuggestionsCollectionView.delegate = self
		drinkSuggestionsCollectionView.dataSource = self
//		alcoholTypeApiProcessor.delegate = self
		let layout = UICollectionViewFlowLayout()
		layout.scrollDirection = .horizontal
		layout.itemSize = CGSize(width: 190, height: 330)
		self.drinkSuggestionsCollectionView.collectionViewLayout = layout
		self.drinkSuggestionsCollectionView.reloadData()
		if let alcoholType = ingredientName.text {
//			print("fuck")
			self.alcoholTypeApiProcessor.fetchCocktails(alcoholName: alcoholType)
		}
		
//		print("oh hey")
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}
	
	@IBAction func seeAllTapped(_ sender: UIButton) {
		print("See All button was tapped for \(ingredientName.text!)")
		
	}
}

//MARK: - UICollectionViewDelegate
extension IngredientsTableViewCell: UICollectionViewDelegate {
	
}

//MARK: - UICollectionViewDataSource
extension IngredientsTableViewCell: UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//		print(self.drinks.count)
		return 5
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DrinksCollectionViewCellID", for: indexPath as IndexPath) as! DrinksCollectionViewCell
		
		if let randomElement = drinks.randomElement() {
			cell.cocktailName.text = randomElement.strDrink
			if let stringURL = URL(string: randomElement.strDrinkThumb) {
				cell.cocktailImage.load(url: stringURL)
			}
			
		}
		
		return cell
	}
}

//MARK: - AlcoholTypeDrinksDelegate
//extension IngredientsTableViewCell: AlcoholTypeDrinksDelegate {
//	func didUpdateCocktailes(_ alcoholTypeApiProcessor: AlcoholTypeApiProcessor, drinks: [Drink]) {
//		DispatchQueue.main.async {
//			self.drinks = drinks
//			print(drinks.count)
//			self.drinkSuggestionsCollectionView.reloadData()
//		}
//	}
//
//	func didFailWithError(error: Error) {
//		DispatchQueue.main.async {
//			//			let drink = Drink(strDrink: "No results found.", strDrinkThumb: "", idDrink: "")
//			//			self.drinks = [drink]
//			//			self.drinkSuggestionsCollectionView.reloadData()
//			print(error)
//
//		}
//	}
//}

