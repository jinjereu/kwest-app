//
//  VenueDetailTableViewCell.swift
//  KwestApp
//
//  Created by Ingrid Silapan on 22/07/19.
//  Copyright © 2019 irs. All rights reserved.
//

import UIKit

class VenueDetailTableViewCell: UITableViewCell {
	
	@IBOutlet weak var iconImageView: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var subtitleLabel: UILabel!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		titleLabel.font = UIFont.systemFont(ofSize: 17.0, weight: .bold)
		titleLabel.textColor = .darkGray
		titleLabel.numberOfLines = 0
		
		subtitleLabel.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
		subtitleLabel.textColor = .darkGray
		subtitleLabel.numberOfLines = 0
		
		multipleSelectionBackgroundView?.backgroundColor = .red
	}
	
	var vm: VenueViewModel? {
		didSet {
			if let vm = vm {
				titleLabel.text = vm.name
				subtitleLabel.text = vm.description
				iconImageView.image = vm.image
			}
		}
	}
	
}
