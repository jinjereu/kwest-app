//
//  VenueViewModel.swift
//  KwestApp
//
//  Created by Ingrid Silapan on 22/07/19.
//  Copyright © 2019 irs. All rights reserved.
//

import Foundation
import MapKit

struct VenueViewModel {
	let venue: Venue
	
	init(venue: Venue) {
		self.venue = venue
	}
	
}

extension VenueViewModel {
	
	var id: Int {
		return venue.id
	}
	
	var type: String {
		return venue.type.rawValue
	}
	
	var image: UIImage {
		switch venue.type {
		case .food:
			return UIImage(named: "food")!
		case .drink:
			return UIImage(named: "drink")!
		case .party:
			return UIImage(named: "party")!
		}
	}
	
	var name: String {
		return venue.name
	}
	
	var description: String {
		return venue.description
	}
	
	var coordinate: CLLocationCoordinate2D {
		return CLLocationCoordinate2DMake(venue.latitude, venue.longitude)
	}

}
