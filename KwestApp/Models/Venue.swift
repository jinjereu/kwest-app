//
//  QuestDetail.swift
//  KwestApp
//
//  Created by Ingrid Silapan on 22/07/19.
//  Copyright © 2019 irs. All rights reserved.
//

import Foundation

enum VenueType: String, Codable {
	case food
	case drink
	case party
}

struct Venue: Codable {
	let id: Int
	let type: VenueType
	let description: String
	let name: String
	let latitude: Double
	let longitude: Double
}

extension Venue {
	
	static func getAll(questId: Int) -> Resource<[Venue]> {
		
		guard let url = URL.venues(questId: String(questId)) else {
			fatalError("URL is not defined!")
		}
		
		return Resource<[Venue]>(url: url)
		
	}
	
}
