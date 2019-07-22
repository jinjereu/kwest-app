//
//  URL+Extensions.swift
//  KwestApp
//
//  Created by Ingrid Silapan on 22/07/19.
//  Copyright © 2019 irs. All rights reserved.
//

import Foundation

extension URL {
	
	static var base: String {
		return "https://my-json-server.typicode.com/jinjereu/kwest-api-mock"
	}
	
	static var quests: URL? {
		return URL(string: base + "/quests")
	}
	
	static func venues(questId: String) -> URL? {
		return URL(string: base + "/venues?questId=" + questId)
	}
	
}
