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
	@IBOutlet weak var tempLoading: UIActivityIndicatorView!
	
	@IBOutlet weak var scrollView: UIScrollView!
	@IBOutlet weak var cocktailImage1: UIImageView!
	@IBOutlet weak var cocktailImage2: UIImageView!
	@IBOutlet weak var cocktailImage3: UIImageView!
		
	var drinks: [Drink] = []
	var alcoholTypeApiProcessor = AlcoholTypeApiProcessor()
	
//	func scrollViewDidScroll(_ scrollView: UIScrollView) {
//		let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
//		previewPageView.currentPage = Int(pageNumber)
////		cocktailName.text = drinkNames[Int(pageNumber)]
//		print(pageNumber)
//	}
	
	func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
				let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
				previewPageView.currentPage = Int(pageNumber)
		//		cocktailName.text = drinkNames[Int(pageNumber)]
				print(pageNumber)
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
		ingredientPhotoBackground.layer.cornerRadius = 20
		ingredientPhotoBackground.layer.masksToBounds = true
		ingredientPhotoBackground.layer.borderWidth = 1
		ingredientPhotoBackground.layer.borderColor = UIColor.systemGray.cgColor
//		alcoholTypeApiProcessor.delegate = self
		
//		if let alcoholType = ingredientName.text {
//			self.alcoholTypeApiProcessor.fetchCocktails(alcoholName: alcoholType)
//		}
		
		previewPageView.numberOfPages = 3
		scrollView.showsHorizontalScrollIndicator = false

		scrollView.delegate = self
		
		self.setupScreens()
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}
	
	@IBAction func seeAllButtonTapped(_ sender: UIButton) {
	}
	
	func setupScreens() {
		scrollView.isPagingEnabled = true
		
//		var pageCount = 0
//		if drinks.count < 3 {
//			pageCount = drinks.count
//		}
//
//
//		for index in 0..<pageCount {
//			frame.origin.x = previewScrollView.frame.size.width * CGFloat(index)
//			frame.size = previewScrollView.frame.size
//
//			let imgView = UIImageView(frame: frame)
//			//			if let stringURL = URL(string: drinks.randomElement().strDrinkThumb) {
//			//				imgView.load(url: stringURL)
//			//			}
//			//			self.previewScrollView.addSubview(imgView)
//
//
//			print("test")
//			print(drinks.count)
//
//			if let randomElement = drinks.randomElement() {
//
//				if let stringURL = URL(string: randomElement.strDrinkThumb) {
//					imgView.load(url: stringURL)
//
//				}
//			}
//
//
//
//
//		}
			
		scrollView.contentSize = CGSize(width: scrollView.frame.size.width * CGFloat(3), height: scrollView.frame.size.height)
	
	}
	
}


//MARK: - UIScrollViewDelegate
//extension IngredientsPreviewTableViewCell: UIScrollViewDelegate {
//func scrollViewDidScroll(_ scrollView: UIScrollView) {
//	let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
//	previewPageView.currentPage = Int(pageNumber)
////		cocktailName.text = drinkNames[Int(pageNumber)]
//	print(pageNumber)
//}
//}

////MARK: - AlcoholTypeDrinksDelegate
//extension IngredientsPreviewTableViewCell: AlcoholTypeDrinksDelegate {
//	func didUpdateCocktailes(_ alcoholTypeApiProcessor: AlcoholTypeApiProcessor, drinks: [Drink]) {
//		DispatchQueue.main.async {
////			print(drinks.count)
//			self.drinks = drinks
//		}
//	}
//	
//	func didFailWithError(error: Error) {
//		DispatchQueue.main.async {
//			print(error)
//		}
//	}
//}
//

