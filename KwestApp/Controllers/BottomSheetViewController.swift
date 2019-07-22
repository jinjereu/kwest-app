//
//  BottomSheetViewController.swift
//  KwestApp
//
//  Created by Ingrid Silapan on 22/07/19.
//  Copyright © 2019 irs. All rights reserved.
//

import UIKit

class BottomSheetViewController: UIViewController {
	
	var vm: BottomSheetViewModel? {
		didSet {
			if tableView != nil {
				tableView.reloadData()
			}
		}
	}
	
	@IBOutlet weak var touchBarView: UIView!
	@IBOutlet weak var titleLabel: UILabel!
	@IBOutlet weak var instructionLabel: UILabel!
	@IBOutlet weak var tableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupUI()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		UIView.animate(withDuration: 0.3) { [weak self] in
			guard let frame = self?.view.frame else { return }
			let yComponent = UIScreen.main.bounds.height - 200
			self?.view.frame = CGRect(x: 0, y: yComponent,
									  width: frame.width, height: frame.height)
			
		}
	}
	
	func setupUI(){
		let gesture = UIPanGestureRecognizer.init(target: self, action: #selector(BottomSheetViewController.panGesture))
		view.addGestureRecognizer(gesture)
		
		let blurEffect = UIBlurEffect.init(style: .light)
		let visualEffect = UIVisualEffectView.init(effect: blurEffect)
		let bluredView = UIVisualEffectView.init(effect: blurEffect)
		bluredView.contentView.addSubview(visualEffect)
		
		visualEffect.frame = UIScreen.main.bounds
		bluredView.frame = UIScreen.main.bounds
		view.layer.cornerRadius = 20
		view.layer.masksToBounds = true
		
		view.insertSubview(bluredView, at: 0)
		
		touchBarView.layer.cornerRadius = 2.5
		touchBarView.layer.masksToBounds = true
		
		titleLabel.text = vm?.detailVM.questVM.title
		titleLabel.font = UIFont.systemFont(ofSize: 24.0, weight: .bold)
		titleLabel.textColor = .darkGray
		titleLabel.numberOfLines = 0
		
		instructionLabel.font = UIFont.systemFont(ofSize: 20.0, weight: .regular)
		instructionLabel.textColor = .darkGray
		instructionLabel.numberOfLines = 0
		instructionLabel.text = "Start the quest. See if you can find your way to these places!"
		
		let nib = UINib.init(nibName: VenueDetailTableViewCell.className, bundle: nil)
		tableView.register(nib, forCellReuseIdentifier: VenueDetailTableViewCell.className)
		
		tableView.dataSource = self
		tableView.delegate = self
		tableView.allowsMultipleSelection = true
		
	}
	
	@objc
	func panGesture(recognizer: UIPanGestureRecognizer) {
		let translation = recognizer.translation(in: self.view)
		let y = self.view.frame.minY
		self.view.frame = CGRect(x:0, y: y + translation.y,
								 width: view.frame.width, height: view.frame.height)
		recognizer.setTranslation(CGPoint.zero, in: self.view)
	}
}

extension BottomSheetViewController: UITableViewDelegate, UITableViewDataSource {
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return vm?.detailVM.venuesVM.count ?? 0
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: VenueDetailTableViewCell.className, for: indexPath) as! VenueDetailTableViewCell
		let venueVM = vm?.detailVM.venuesVM[indexPath.row]
		cell.vm = venueVM
		return cell
	}
	
}
