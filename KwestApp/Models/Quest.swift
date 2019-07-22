//
//  Quest.swift
//  KwestApp
//
//  Created by Ingrid Silapan on 21/07/19.
//  Copyright © 2019 irs. All rights reserved.
//

import Foundation


struct Quest: Codable {
	let id: Int
	let title: String
	let imageSource: String
}

extension Quest {
	
	static var getAll: Resource<[Quest]> = {
		
		guard let url = URL.quests else {
			fatalError("URL is not defined!")
		}
		
		return Resource<[Quest]>(url: url)
		
	}()
	
}
