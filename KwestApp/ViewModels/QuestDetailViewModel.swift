//
//  QuestDetailViewModel.swift
//  KwestApp
//
//  Created by Ingrid Silapan on 22/07/19.
//  Copyright © 2019 irs. All rights reserved.
//

import Foundation

class QuestDetailViewModel {
	let questVM: QuestViewModel
	var venuesVM: [VenueViewModel]
	
	init(questVM: QuestViewModel) {
		self.questVM = questVM
		self.venuesVM = [VenueViewModel]()
	}
}

extension QuestDetailViewModel {
	
	func venueVM(at index: Int) -> VenueViewModel {
		return self.venuesVM[index]
	}
	
}
