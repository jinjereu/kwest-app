//
//  View+Extensions.swift
//  KwestApp
//
//  Created by Ingrid Silapan on 22/07/19.
//  Copyright © 2019 irs. All rights reserved.
//  addParallaxEffect() taken at: https://gist.github.com/ziadtamim/42f40332ef29f7892bd036cad9177fb0#file-viewcontroller-swift
//

import Foundation
import UIKit

extension UIView {
	
	func addParallaxEffect() {
		let min = CGFloat(-30)
		let max = CGFloat(30)
		
		let xMotion = UIInterpolatingMotionEffect(keyPath: "layer.transform.translation.x", type: .tiltAlongHorizontalAxis)
		xMotion.minimumRelativeValue = min
		xMotion.maximumRelativeValue = max
		
		let yMotion = UIInterpolatingMotionEffect(keyPath: "layer.transform.translation.y", type: .tiltAlongVerticalAxis)
		yMotion.minimumRelativeValue = min
		yMotion.maximumRelativeValue = max
		
		let motionEffectGroup = UIMotionEffectGroup()
		motionEffectGroup.motionEffects = [xMotion,yMotion]
		
		self.addMotionEffect(motionEffectGroup)
	}
	
}
