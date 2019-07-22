//
//  APIResource.swift
//  KwestApp
//
//  Created by Ingrid Silapan on 22/07/19.
//  Copyright © 2019 irs. All rights reserved.
//

import Foundation

enum NetworkError: Error {
	case decodingError
	case domainError
	case urlError
}

enum HttpMethod: String {
	case get = "GET"
	case post = "POST"
}

struct Resource<T: Codable> {
	let url: URL
	var httpMethod: HttpMethod = .get
	var body: Data? = nil
}

extension Resource {
	init(url: URL) {
		self.url = url
	}
}
