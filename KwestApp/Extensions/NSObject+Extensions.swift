//
//  NSObject+Extensions.swift
//  KwestApp
//
//  Created by Ingrid Silapan on 21/07/19.
//  Copyright © 2019 irs. All rights reserved.
//

import Foundation

extension NSObject {
	
	var className: String {
		return String(describing: self)
	}
	
	class var className: String {
		return String(describing: self)
	}
	
}
