//
//  LocationListing.swift
//  RestaurantListing
//
//  Created by Kaushal on 14/08/19.
//  Copyright © 2019 test. All rights reserved.
//

import Foundation
struct LocationListing{
	let results : [Results]
	let status : String
}

struct Results {
	let geometry : Geometry?
	let icon : String?
	let id : String?
	let name : String?
	let opening_hours : Opening_hours?
	let place_id : String?
	let reference : String?
	let scope : String?
	let types : [String]?
	let vicinity : String?
	let rating: String?
	let photos:[Photos]?
}

struct Opening_hours {
	let open_now : Bool?
	//let weekday_text : [Weekday_text]
}
struct Geometry {
	let location : Location?
	let viewport : Viewport?
}

struct Viewport {
	let northeast : Northeast
	let southwest : Southwest
}

struct Southwest {
	let lat : Double
	let lng : Double
}

struct Northeast {
	let lat : Double
	let lng : Double
}

struct Location {
	let lat : Double?
	let lng : Double?
}
struct Photos {
	let height : UInt
	let html_attributions : [String]
	let photo_reference : String
	let width : UInt
}
