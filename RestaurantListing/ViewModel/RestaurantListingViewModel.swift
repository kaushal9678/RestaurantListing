//
//  RestaurantListingViewModel.swift
//  RestaurantListing
//
//  Created by Kaushal on 14/08/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation

import Foundation

struct RestaurantListingViewModel: CellWithTextViewAndButtonPresentable {
	var restaurantLogo: String
	
	
	var restaurantNametext: String
	
	var restaurantAddressText: String
	
	var restaurantOpenStatus: Bool
	
	var restaurantRating: String
	
	var arrayPhotos:[Photos]
	
	var imageRating: String
	
	
	
	
}

// MARK: TextPresentable Conformance
extension RestaurantListingViewModel {
	//  var stationNametext: String { return "Minion Mode" }
	// var stationAddressText: String { return "New Kondli" }
	//var directionText: String { return "Directions" }
	//var imagename:String{return "direction.png"}
	var directionText: String { return "Directions" }
	var imagename:String{return "direction.png"}
	
	//var textColor: UIColor { return .blackColor() }
	//var font: UIFont { return .systemFontOfSize(17.0) }
}

// MARK: SwitchPresentable Conformance
extension RestaurantListingViewModel {
	
	func onBtnClick(sender: AnyObject) {
		print("called")
	}
}
