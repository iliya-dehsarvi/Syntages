//
//  IngredientsPreviewTableViewCell.swift
//  Syntages
//
//  Created by Iliya dehsarvi on 7/23/21.
//

import UIKit

class IngredientsPreviewTableViewCell: UITableViewCell, UIScrollViewDelegate {
	
	@IBOutlet weak var ingredientPhotoBackground: UIView!
	@IBOutlet weak var inegredientImage: UIImageView!
	@IBOutlet weak var ingredientName: UILabel!
	@IBOutlet weak var previewScrollView: UIScrollView!
	@IBOutlet weak var previewPageView: UIPageControl!
	@IBOutlet weak var cocktailName: UILabel!
	@IBOutlet weak var cocktailRecipe: UILabel!
	@IBOutlet weak var cocktailHashtags: UILabel!
	
	var drinks: [Drink] = []
	var alcoholTypeApiProcessor = AlcoholTypeApiProcessor()
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		ingredientPhotoBackground.layer.cornerRadius = 20
		ingredientPhotoBackground.layer.masksToBounds = true
		ingredientPhotoBackground.layer.borderWidth = 1
		ingredientPhotoBackground.layer.borderColor = UIColor.white.cgColor
		alcoholTypeApiProcessor.delegate = self
		
		if let alcoholType = ingredientName.text {
			self.alcoholTypeApiProcessor.fetchCocktails(alcoholName: alcoholType)
		}
		
		previewPageView.numberOfPages = 3
		setupScreens()
		
//		previewScrollView.delegate = self
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}
	
	@IBAction func seeAllButtonTapped(_ sender: UIButton) {
	}
	
	func setupScreens() {
		for index in 0..<3 {
			frame.origin.x = previewScrollView.frame.size.width * CGFloat(index)
			frame.size = previewScrollView.frame.size
			
			let imgView = UIImageView(frame: frame)
//			if let stringURL = URL(string: drinks.randomElement().strDrinkThumb) {
//				imgView.load(url: stringURL)
//			}
//			self.previewScrollView.addSubview(imgView)

			
			
			if let randomElement = drinks.randomElement() {
				if let stringURL = URL(string: randomElement.strDrinkThumb) {
					imgView.load(url: stringURL)
				}
			}
			
			
		
			
		}
		previewScrollView.contentSize = CGSize(width: (previewScrollView.frame.size.width * CGFloat(3)), height: previewScrollView.frame.size.height)
//		previewScrollView.delegate = self
	}
	
}
////MARK: - AlcoholTypeDrinksDelegate
//extension IngredientsPreviewTableViewCell: UIScrollViewDelegate {
//	func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//	    let pageNumber = previewScrollView.contentOffset.x / previewScrollView.frame.size.width
//		previewPageView.currentPage = Int(pageNumber)
//	}
//}

//MARK: - AlcoholTypeDrinksDelegate
extension IngredientsPreviewTableViewCell: AlcoholTypeDrinksDelegate {
	func didUpdateCocktailes(_ alcoholTypeApiProcessor: AlcoholTypeApiProcessor, drinks: [Drink]) {
		DispatchQueue.main.async {
			print(drinks.count)
			self.drinks = drinks
		}
	}
	
	func didFailWithError(error: Error) {
		DispatchQueue.main.async {
			print(error)
		}
	}
}


