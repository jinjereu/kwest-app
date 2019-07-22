//
//  QuestViewModel.swift
//  KwestApp
//
//  Created by Ingrid Silapan on 22/07/19.
//  Copyright © 2019 irs. All rights reserved.
//

import Foundation

class QuestListViewModel {
	
	var questsVM: [QuestViewModel]
	
	init() {
		self.questsVM = [QuestViewModel]()
	}
}

extension QuestListViewModel {
	
	func questViewModel(at index: Int) -> QuestViewModel {
		return self.questsVM[index]
	}
	
}

struct QuestViewModel {
	let quest: Quest
	
	init(quest: Quest) {
		self.quest = quest
	}
}

extension QuestViewModel {
	
	var id: Int {
		return self.quest.id
	}
	
	var title: String {
		return self.quest.title
	}
	
	var imageSource: String {
		return self.quest.imageSource
	}
	
}
