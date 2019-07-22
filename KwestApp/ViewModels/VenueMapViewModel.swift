//
//  VenueMapViewModel.swift
//  KwestApp
//
//  Created by Ingrid Silapan on 22/07/19.
//  Copyright © 2019 irs. All rights reserved.
//

import Foundation
import MapKit

public class VenueMapViewModel: NSObject {
	public let coordinate: CLLocationCoordinate2D
	public let id: Int
	public let name: String
	public let image: UIImage
	
	public init(coordinate: CLLocationCoordinate2D,
				id: Int,
				name: String,
				image: UIImage) {
		self.coordinate = coordinate
		self.id = id
		self.name = name
		self.image = image
	}
}

// MARK: - MKAnnotation

extension VenueMapViewModel: MKAnnotation {
	
	public var title: String? {
		return name
	}
	
}
