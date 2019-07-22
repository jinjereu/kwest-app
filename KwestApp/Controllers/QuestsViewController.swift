//
//  PlacesViewController.swift
//  KwestApp
//
//  Created by Ingrid Silapan on 21/07/19.
//  Copyright © 2019 irs. All rights reserved.
//

import Foundation
import UIKit


class QuestsViewController: UIViewController {
	
	fileprivate var questListVM = QuestListViewModel()
	fileprivate var selectedVM: QuestViewModel?
	
	@IBOutlet weak var questsCollectionView: UICollectionView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupUI()
		getQuests()
	}
	
	private func getQuests() {
		APIService().load(resource: Quest.getAll) {[weak self] result in
			switch result {
			case .success(let quests):
				self?.questListVM.questsVM = quests.map(QuestViewModel.init)
				self?.questsCollectionView.reloadData()
			case .failure(let error):
				print(error)
			}
		}
	}
	
	private func setupUI() {
		title = "Quests"
		navigationController?.navigationBar.prefersLargeTitles = true
		
		let titleTextForeground = UIColor(red:0.10, green:0.18, blue:0.24, alpha:1.0)
		navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: titleTextForeground]
		
		if #available(iOS 11.0, *) {
			navigationController?.navigationBar.largeTitleTextAttributes = [
				.foregroundColor: titleTextForeground
			]
		}
		
		navigationController?.navigationBar.barTintColor = UIColor(red:1.00, green:0.81, blue:0.29, alpha:1.0)
		questsCollectionView.backgroundColor = UIColor(red:0.15, green:0.82, blue:0.84, alpha:1.0)

	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		super.prepare(for: segue, sender: nil)
		
		if segue.identifier ==  QuestDetailViewController.className {
			let nav = segue.destination as! UINavigationController
			if let vc = nav.children.first as? QuestDetailViewController {
				guard let vm = selectedVM else { return }
				let questDetailViewModel = QuestDetailViewModel(questVM: vm)
				vc.vm = questDetailViewModel
			}
		}
		
	}
}

//MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout

extension QuestsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
	
	func numberOfSections(in collectionView: UICollectionView) -> Int {
		return 1
	}
	
	func collectionView(_ collectionView: UICollectionView,
						numberOfItemsInSection section: Int) -> Int {
		return questListVM.questsVM.count
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
		return UIEdgeInsets(top: 30, left: 0, bottom: 70, right: 0)
	}
	
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		let padding: CGFloat = 30.0
		let itemWidth = collectionView.frame.size.width - (padding * 2.0)
		let itemHeight = itemWidth * 1.25
		return CGSize(width: itemWidth, height: itemHeight)
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier:
			QuestCollectionViewCell.className, for: indexPath) as! QuestCollectionViewCell
			let vm = questListVM.questsVM[indexPath.row]
			cell.vm = vm
		
		return cell
	}
	
	func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
		cell.alpha = 0
		UIView.animate(withDuration: 0.8) {
			cell.alpha = 1
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		selectedVM = questListVM.questsVM[indexPath.row]
		performSegue(withIdentifier: QuestDetailViewController.className, sender: nil)
	}
}



