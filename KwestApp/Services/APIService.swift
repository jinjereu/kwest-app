//
//  APIService.swift
//  KwestApp
//
//  Created by Ingrid Silapan on 22/07/19.
//  Copyright © 2019 irs. All rights reserved.
//

import Foundation


class APIService {
	
	func load<T>(resource: Resource<T>, completion: @escaping (Result<T,NetworkError>) -> Void) {
		
		var request = URLRequest(url: resource.url)
		request.httpMethod = resource.httpMethod.rawValue
		request.httpBody = resource.body
		request.addValue("application/json", forHTTPHeaderField: "Content-Type")
		
		URLSession.shared.dataTask(with: request) { data, response, error in
			
			guard let data = data, error == nil else {
				completion(.failure(.domainError))
				return
			}
			
			let result = try? JSONDecoder().decode(T.self, from: data)
			if let result = result {
				DispatchQueue.main.async {
					completion(.success(result))
				}
			} else {
				completion(.failure(.decodingError))
			}
			
			}.resume()
	}
	
}
