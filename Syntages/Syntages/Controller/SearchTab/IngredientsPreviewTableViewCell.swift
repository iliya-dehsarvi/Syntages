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
	
	var _frame: CGRect = CGRect(x: 0, y: 0, width: 0, height: 0)
	
	var drinks: [Drink] = []
	var alcoholTypeApiProcessor = AlcoholTypeApiProcessor()
	
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
		//		previewScrollView.delegate = self
		
		self.setupScreens()
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}
	
	@IBAction func seeAllButtonTapped(_ sender: UIButton) {
	}
	
	func setupScreens() {
		previewScrollView.isPagingEnabled = true
		
		var pageCount = 0
		if drinks.count < 3 {
			pageCount = drinks.count
		}
		
		
		for index in 0..<pageCount {
			frame.origin.x = previewScrollView.frame.size.width * CGFloat(index)
			frame.size = previewScrollView.frame.size
			
			let imgView = UIImageView(frame: frame)
			//			if let stringURL = URL(string: drinks.randomElement().strDrinkThumb) {
			//				imgView.load(url: stringURL)
			//			}
			//			self.previewScrollView.addSubview(imgView)
			
			
			print("test")
			print(drinks.count)

			if let randomElement = drinks.randomElement() {

				if let stringURL = URL(string: randomElement.strDrinkThumb) {
					imgView.load(url: stringURL)
					
				}
			}
			
			
			
			
		}
		previewScrollView.contentSize = CGSize(width: previewScrollView.frame.size.width * CGFloat(pageCount), height: previewScrollView.frame.size.height)
	}
	
}
//MARK: - UIScrollViewDelegate
//extension IngredientsPreviewTableViewCell: UIScrollViewDelegate {
//	    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//		   var page = scrollView.contentOffset.x/scrollView.frame.size.width
//		   pageControl.currentPage = Int(page)
//	    }
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

