//
//  QuestDetailViewController.swift
//  KwestApp
//
//  Created by Ingrid Silapan on 21/07/19.
//  Copyright © 2019 irs. All rights reserved.
//

import UIKit
import MapKit

class QuestDetailViewController: UIViewController {
	
	@IBOutlet weak var dismissButton: UIButton!
	@IBOutlet weak var mapView: MKMapView! {
		didSet {
			mapView.showsUserLocation = true
		}
	}
	let bottomSheetVC = BottomSheetViewController()
	
	var vm: QuestDetailViewModel?
	private let locationManager = CLLocationManager()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setupUI()
		locationManager.requestWhenInUseAuthorization()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		addBottomSheetView()
	}
	
	private func setupUI() {
		let image = UIImage(named: "error")?.withRenderingMode(.alwaysTemplate)
		dismissButton.setImage(image, for: .normal)
		dismissButton.tintColor = .darkGray
	}
	
	private func addBottomSheetView() {
		guard let vm = vm else { return }
		bottomSheetVC.vm = BottomSheetViewModel(detailVM: vm)
		
		self.addChild(bottomSheetVC)
		self.view.addSubview(bottomSheetVC.view)
		bottomSheetVC.didMove(toParent: self)
		
		let height = view.frame.height
		let width  = view.frame.width
		bottomSheetVC.view.frame = CGRect(x: 0, y: self.view.frame.maxY,
										  width: width, height: height)
	}
	
	private func reloadBottomSheet() {
		guard let vm = vm else { return }
		bottomSheetVC.vm = BottomSheetViewModel(detailVM: vm)
	}
	
	@IBAction func dismissView(_ sender: Any) {
		self.navigationController?.dismiss(animated: true, completion: nil)
	}
	
}

//MARK: - MKMapViewDelegate

extension QuestDetailViewController: MKMapViewDelegate {
	
	func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
		centerMap(on: userLocation.coordinate)
	}
	
	private func centerMap(on coordinate: CLLocationCoordinate2D) {
		let regionRadius: CLLocationDistance = 3000
		let coordinateRegion = MKCoordinateRegion(center: coordinate,
												  latitudinalMeters: regionRadius,
												  longitudinalMeters: regionRadius)
		mapView.setRegion(coordinateRegion, animated: true)
		getQuestDetails()
	}
	
	private func getQuestDetails() {
		let coordinate = mapView.userLocation.coordinate
		guard coordinate.latitude != 0 && coordinate.longitude != 0 else { return }
		
		guard let questId = vm?.questVM.id else { return }
		
		APIService().load(resource: Venue.getAll(questId: questId)) {[weak self] result in
			switch result {
			case .success(let venues):
				self?.vm?.venuesVM = venues.map(VenueViewModel.init)
				self?.addAnnotations()
				self?.reloadBottomSheet()
			case .failure(let error):
				print(error)
			}
		}
	}
	
	private func addAnnotations() {
		guard let venuesVM = vm?.venuesVM else { return }
		
		for venueVM in venuesVM {
			let image: UIImage
			guard let venueType = VenueType(rawValue: venueVM.type) else { return }
			switch venueType {
			case .food:
				image = UIImage(named: "food")!
			case .drink:
				image = UIImage(named: "drink")!
			case .party:
				image = UIImage(named: "party")!
			}
			
			let annotation = VenueMapViewModel(coordinate: venueVM.coordinate, id: venueVM.id, name: venueVM.name, image: image)
			mapView.addAnnotation(annotation)
		}
	}
	
	public func mapView(_ mapView: MKMapView,
						viewFor annotation: MKAnnotation) -> MKAnnotationView? {
		guard let viewModel = annotation as? VenueMapViewModel else {
			return nil
		}
		
		let identifier = "venue"
		let annotationView: MKAnnotationView
		if let existingView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
			annotationView = existingView
		} else {
			annotationView = MKAnnotationView(annotation: viewModel,
											  reuseIdentifier: identifier)
		}
		
		annotationView.image = viewModel.image
		annotationView.canShowCallout = true
		return annotationView
	}
	
}
