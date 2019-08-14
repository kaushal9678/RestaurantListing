//
//  ViewController.swift
//  RestaurantListing
//
//  Created by Kaushal on 14/08/19.
//  Copyright © 2019 test. All rights reserved.
//

import UIKit
import CoreLocation
class ViewController: UIViewController {

	
	
	@IBOutlet weak var tableViewRestaurantListing: UITableView!
	
	
	let userdef = UserDefaults.standard
	
	let restAPIManager = RestAPIManager()
	var didFindMyLocation = false
	var distance:Double = 0.00
	var  arrayOfResults:[Results]? = [Results]()
	
	
	// location manager
	var locationManager: CLLocationManager!
	var currentPosition:CLLocationCoordinate2D?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		locationManager = CLLocationManager()
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.distanceFilter = 3000; // 3km
		locationManager.delegate = self
		locationManager.requestAlwaysAuthorization()
	
		//self.tableViewRestaurantListing.reloadData()
		
	}

	//MARK: Fetch Stations near current location
	//MARK: request a Google API for gas_stations
	func fetchStationsThroughGoogleAPI(queryType:String){
		
		let currentDist = 3000;
		// Build the url string we are going to sent to Google. NOTE: The KEY_GOOGLE_MAP_SERVER_KEY is a constant which should contain your own API key that you can obtain from Google. See this link for more info:
		// https://developers.google.com/maps/documentation/places/#Authentication
		// NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?location=%f,%f&radius=%@&types=%@&sensor=true&key=%@", latitude, lngitude, [NSString stringWithFormat:@"%i", currenDist], googleType, KEY_GOOGLE_MAP_SERVER_KEY];
		
		let url = String.init(format: "https://maps.googleapis.com/maps/api/place/search/json?location=%f,%f&radius=%d&types=%@&sensor=true&key=%@",(currentPosition?.latitude)!,(currentPosition?.longitude)!,currentDist,queryType,KEY_GOOGLE_MAP_SERVER_KEY)
		
		//   let url = String.init(format: "%@=%f,%f&radius=%d&types=%@&sensor=true&key=%@", KEY_GOOGLE_STATIONS_API,(currentPosition?.latitude)!,(currentPosition?.longitude)!,currentDist,queryType,KEY_GOOGLE_MAP_SERVER_KEY)
		
		restAPIManager.fetchDataFromServer(url, parameters: nil) { (status, JSON) in
			print(status)
			let dictResponse = JSON as? [String:AnyObject]
			//The results from Google will be an array obtained from the NSDictionary object with the key "results".
			let places = dictResponse?["results"]as? NSArray
			// Write out the data to the console.
			print("Google Data: %@", places);
			self.plotPositions(places!)
			
		}
		
	}
	//MARK: drop pins
	func plotPositions(_ arrayData:NSArray){
		
		let count: Int = Int(arrayData.count)
		
		let center:CLLocationCoordinate2D = CLLocationCoordinate2DMake((currentPosition?.latitude)!,(currentPosition?.longitude)!);
		
		let radius:Float = 5*1000; //radius in meters (25km)
		let radiusDouble = radius * 2.0
		
		/*let region: MKCoordinateRegion = MKCoordinateRegionMakeWithDistance(center, CLLocationDistance(radiusDouble), CLLocationDistance(radiusDouble));
		
		let northEast:CLLocationCoordinate2D   = CLLocationCoordinate2DMake(region.center.latitude - region.span.latitudeDelta/2, region.center.longitude - region.span.longitudeDelta/2);
		let southWest: CLLocationCoordinate2D   = CLLocationCoordinate2DMake(region.center.latitude + region.span.latitudeDelta/2, region.center.longitude + region.span.longitudeDelta/2);
		
		let bounds: GMSCoordinateBounds  = GMSCoordinateBounds.init(coordinate: southWest, coordinate: northEast)
		*/
		
		for index in 0..<count    {
			
			//Retrieve the NSDictionary object in each index of the array.
			let place = arrayData.object(at: index)as? [String:AnyObject]
			//There is a specific NSDictionary object that gives us location info.
			let geo = place?["geometry"]as? [String:AnyObject]
			//Get our name and address info for adding to a pin.
			let name = place?["name"] as? String
			
			let vicinity = place?["vicinity"]as? String;
			
			//Get the lat and long for the location.
			let loc = geo?["location"] as? [String:AnyObject];
			
			//Create a special variable to hold this coordinate info.
			var placeCoord:CLLocationCoordinate2D? = nil
			
			//Set the lat and long.
			placeCoord?.latitude = (loc?["lat"] as? Double)!;
			placeCoord?.longitude = loc?["lng"]as! Double;
			
			let location = Location(lat:(loc?["lat"] as? Double)!, lng:(loc?["lng"] as? Double)!)
			// let viewPort = ViewPort(northeast:"",southwest:"");
			let geometry = Geometry(location:location,viewport:nil)
			
			// get opening hours
			let openingHrsDict = place?["opening_hours"]as? [String:AnyObject]
			var openNow:Bool?
			
			if let opennow = openingHrsDict?["open_now"]as? Bool{
				openNow = opennow
			}
			
			let openingHours = Opening_hours(open_now:openNow)
			
			//get id of address
			var idAddress:String? = nil
			if let id = place?["id"]as? String{
				idAddress = id
			}
			
			//get icon of address
			var iconImage:String? = nil
			if let icon = place?["icon"]as? String{
				iconImage = icon
			}
			
			
			// get rating
			
			var rating:String? = nil
			if let ratingValue = place?["rating"]as? Double{
				rating = String.init(format: "%.1f", ratingValue);
			}
			// get place_id
			var place_id:String? = nil
			if let placeId =  place?["place_id"]as? String{
				place_id = placeId
			}
			// get scope
			var scope:String? = nil
			
			if let scopeValue = place?["scope"]as? String{
				scope = scopeValue
			}
			
			// get reference
			var referece:String? =  nil
			if let referenceValue = place?["reference"]as? String{
				referece = referenceValue
			}
			
			var types:[String]? = nil
			if let type = place?["types"]as?[String]{
				types = type
			}
			
			var photos:[Photos]? = [Photos]()
			// get photos
			if let photosArray = place?["photos"]as? NSArray{
				print(photosArray)
				for dict in photosArray{
					let object = dict as? [String:AnyObject]
					let photo = Photos(height: (object?["height"]as? UInt)!,html_attributions:(object?["html_attributions"]as? [String])!,photo_reference:(object?["photo_reference"]as? String)!,width:(object?["width"]as? UInt)!)
					
					photos?.append(photo)
				}
				
				
			}
			
			
			let results = Results(geometry:geometry,icon:iconImage,id:idAddress, name:name,opening_hours:openingHours,place_id:place_id,reference:referece,scope:scope,types:types,vicinity:vicinity,rating:rating,photos:photos)
			
			self.arrayOfResults?.append(results)
			
			DispatchQueue.main.async {
				self.tableViewRestaurantListing.reloadData()
			}
			
			
		}
	}
	
}


//MARK: Delegates and dataSource
extension ViewController: CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource{
	//MARK: UISearchbar delegates
	
	
	//MARK: UITableView DataSource
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return arrayOfResults?.count ?? 0 ;
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantListingcell", for: indexPath) as! RestaurantListingcell
		
		// this is where the magic happens!
		let result = arrayOfResults?[indexPath.row] //as? Results
		let restaurantName = result?.name
		let restaurantAddress =  result?.vicinity
		let openingHrs = result?.opening_hours
		let icon = result?.icon
		var rating:String? = ""
		if let ratingData = result?.rating{
			rating = ratingData
		}
		var openNow = true
		if  let opennow = openingHrs as? Bool{
			openNow = opennow;
		}
		
		let viewModel = RestaurantListingViewModel.init(restaurantLogo: icon ?? "", restaurantNametext: restaurantName ?? "", restaurantAddressText: restaurantAddress ?? "", restaurantOpenStatus: openNow  ?? false, restaurantRating: rating ?? "", arrayPhotos: result?.photos ?? [],imageRating: icon ?? "");
		
		cell.configure(withPresenter: viewModel)
		return cell
	}
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension;
	}
	
	//MARK: tableview Delegates
	/*func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		let result = arrayOfResults?[indexPath.row] //as? Results
		let stationName = result?.name
		let stationAddress =  result?.vicinity
		let geometry = result?.geometry
		let location = geometry?.location
		tableListingBackgroundView.isHidden = true
		//self.viewShowList.isHidden = true
		var placeCoord:CLLocationCoordinate2D? = nil
		//Set the lat and long.
		placeCoord?.latitude = (location?.lat)!;
		placeCoord?.longitude = (location?.lng)!;
		
		if ((placeCoord?.latitude != 0) && (placeCoord?.longitude != 0)) {
			marker.position = CLLocationCoordinate2D(latitude: (location?.lat)!, longitude: (location?.lng)!)
			marker.title = stationName
			marker.snippet = stationAddress
			//marker.icon =  UIImage.init(named: "marker.png")
			marker.icon = UIImage(named: "marker.png")
			marker.map = mapView
			
		}
		let camera = GMSCameraPosition.camera(withLatitude:(location?.lat)!, longitude: (location?.lng)!, zoom: 16.0)
		mapView.camera = camera;
		
		
	}*/
	func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
		if status == .authorizedAlways || status == .authorizedWhenInUse {
			if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
				if CLLocationManager.isRangingAvailable() {
					// do stuff
					
					manager.startUpdatingLocation()
					
				}
			}
		}else if status == .denied{
			
		}else if status == .notDetermined{
			
		}
	}
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		
		let location:CLLocation = locations.last!
		
		currentPosition = location.coordinate
		let lat = userdef.double(forKey: "lat")
		
		let lng = userdef.double(forKey: "lng")
		if currentPosition != nil{
			DispatchQueue.main.async(execute: {
				// UI Updates
				self.fetchStationsThroughGoogleAPI(queryType:"restaurant")
			})
		}
		
		let oldCordinates = CLLocationCoordinate2D.init(latitude: lat, longitude: lng)
		
		// convert old cordinates to CLLocation
		
		// calculate distance between new points and existing ones we have in userdefault
		
		if lat == 0 || lng == 0{
			
		}else{
			if CLLocationCoordinate2DIsValid(oldCordinates){
				let oldLocation =  CLLocation.init(latitude: lat, longitude: lng)
				self.distance = location.distance(from: oldLocation)
				
			}
		}
		
		
		
		
		
		
	}
	func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
		print("Monitoring failed for region with identifier: \(region!.identifier)")
	}
	
	func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
		print("Location Manager failed with the following error: \(error)")
	}
	
}

