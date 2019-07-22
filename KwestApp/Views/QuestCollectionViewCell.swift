//
//  QuestCollectionViewCell.swift
//  KwestApp
//
//  Created by Ingrid Silapan on 21/07/19.
//  Copyright © 2019 irs. All rights reserved.
//

import UIKit
import Kingfisher

class QuestCollectionViewCell: UICollectionViewCell {
	
	@IBOutlet fileprivate weak var imageView: UIImageView!
	@IBOutlet fileprivate weak var textLabel: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		layer.cornerRadius = 6
		layer.masksToBounds = true
		layer.backgroundColor = UIColor.lightGray.cgColor

		textLabel.font = UIFont.systemFont(ofSize: 24.0, weight: .bold)
		textLabel.textColor = .white
		textLabel.numberOfLines = 0
		
		imageView.addParallaxEffect()
		imageView.contentMode = .scaleAspectFill
	}
	
	var vm: QuestViewModel? {
		didSet {
			if let vm = vm {
				textLabel.text = vm.title
				let url = URL(string: vm.imageSource)
				imageView.kf.setImage(with: url)
			}
		}
	}
	
}

