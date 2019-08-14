//
//  RestaurantListingCell.swift
//  RestaurantListing
//
//  Created by Kaushal on 14/08/19.
//  Copyright © 2019 test. All rights reserved.
//



import Foundation
import UIKit

// your label protocol
protocol TextPresentable {
	var restaurantNametext: String { get set}
	var restaurantAddressText: String { get set }
	var restaurantOpenStatus:Bool {get set}
	var restaurantRating:String {get set}
	
	//var textColor: UIColor { get }
	
	//var font: UIFont { get }
}
protocol ImagePresentable {
	var imageName: String { get }
}
protocol buttonPresentable {
	var imagename: String { get }
	var imageRating:String { get}
	var restaurantLogo:String {get}
	
	func onBtnClick(sender: AnyObject)
}
// protocol composition
// based on the UI components in the cell
typealias CellWithTextViewAndButtonPresentable = TextPresentable & buttonPresentable


class RestaurantListingcell: UITableViewCell {
	
	
	@IBOutlet weak var viewContainer: UIView!
	
	@IBOutlet weak var labelRestaurantName: UILabel!
	
	@IBOutlet weak var labelRestaurantType: UILabel!
	
	@IBOutlet weak var imageRating: UIImageView!
	
	@IBOutlet weak var labelRating: UILabel!
	
	@IBOutlet weak var imgRestaurantLogo: UIImageView!
	
	
	@IBOutlet weak var labelRestaurantAddress: UILabel!
	
	@IBOutlet weak var labelRestaurantStatus: UILabel!
	
	var arrayOfPhotos:[Photos]?
	

	
	
	private var delegate: CellWithTextViewAndButtonPresentable?
	// configure with something that conforms to the composed protocol
	func configure(withPresenter presenter: CellWithTextViewAndButtonPresentable) {
		delegate = presenter
		
		// configure the UI components
		labelRestaurantName.text = presenter.restaurantNametext
		labelRestaurantAddress.text = presenter.restaurantAddressText
		
		let restaurantStatus = presenter.restaurantOpenStatus
		
		let rating = presenter.restaurantRating
		var status:String? = nil
		if restaurantStatus == true{
			status = "Open"
		}else{
			status = "Closed"
		}
		var restaurantStatusAndRating:String = ""
		
		//  let formattedString = NSMutableAttributedString()
		
		if  rating.isEmpty == true || rating == ""{
			restaurantStatusAndRating = String.init(format: "Status:%@ ", status!)
			//formattedString.bold(text: "Status:").normal(text: status!)
		}else{
			restaurantStatusAndRating = String.init(format: "Status:%@, Rating:%@ ", status!,rating)
			// formattedString.bold(text: "Status:").normal(text: status!).bold(text: "Rating:").normal(text:rating)
			
		}
		//label.attributedText = formattedString
		labelRating.text = rating;
		//labelRestaurantStatus.text = restaurantStatusAndRating
		let image = UIImage.init(named: presenter.imagename)
		imgRestaurantLogo.image = image;
		//btnDirection.setImage(image, for: .normal)
		//  btnDirection.setImage(named:presenter.imagename)
		//labelDirections.text =  presenter.directionText
		
	}
	
}

/*extension RestaurantListingcell: UICollectionViewDataSource, UICollectionViewDelegate{
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		<#code#>
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		<#code#>
	}
	
	
}*/

extension NSMutableAttributedString {
	func bold(text:String) -> NSMutableAttributedString {
		let attrs:[String:AnyObject] = [NSAttributedString.Key.font.rawValue : UIFont(name: "Thonburi", size: 15.0)!]
		let boldString = NSMutableAttributedString.init(string: "\(text)", attributes: attrs as? [NSAttributedString.Key : Any]) //NSMutableAttributedString(string:"\(text)", attributes:attrs)
		self.append(boldString)
		return self
	}
	
	func normal(text:String)->NSMutableAttributedString {
		let normal =  NSAttributedString(string: text)
		self.append(normal)
		return self
	}
}
