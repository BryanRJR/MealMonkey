//
//  AddressViewController.swift
//  MealMonkey
//
//  Created by MacBook Pro on 06/04/23.
//

import UIKit
import MapKit

class AddressViewController: UIViewController {
  @IBOutlet weak var mapView: MKMapView!
  @IBOutlet weak var addressLabel: UILabel!

  var completion: (CLLocation, String) -> Void = { _, _ in }
  var location: CLLocation?
  var address: String?

  let locationManager = CLLocationManager()

  override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    mapView.showsUserLocation = true

    let gesture = UILongPressGestureRecognizer(target: self, action: #selector(self.longPressHandler(_:)))

    gesture.minimumPressDuration = 0.5
    gesture.delaysTouchesBegan = true
    mapView.addGestureRecognizer(gesture)

    locationManager.requestWhenInUseAuthorization()
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.distanceFilter = kCLDistanceFilterNone
    locationManager.startUpdatingLocation()
    }

  @objc func longPressHandler(_ sender: UILongPressGestureRecognizer) {
    if sender.state != .ended {
      let location = sender.location(in: mapView)
      let coordinate = mapView.convert(location, toCoordinateFrom: mapView)
      getAddressFromCoordinate(coordinate)
    }
  }

  func getAddressFromCoordinate(_ coordinate: CLLocationCoordinate2D) {
    CLGeocoder().reverseGeocodeLocation(CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)) { placemarks, error in
      if let placemark = placemarks?.first {
        self.location = placemark.location
        self.address = placemark.thoroughfare
        self.addressLabel.text = placemark.thoroughfare
      }
    }
  }

  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    zoomToUserLocation()

  }

  func zoomToUserLocation() {
    if let location = mapView.userLocation.location {
      let viewRegion = MKCoordinateRegion(center: location.coordinate, latitudinalMeters: 200, longitudinalMeters: 200)
      mapView.setRegion(viewRegion, animated: true)
    }
  }

  @IBAction func saveButtonTapped(_ sender: Any) {
    dismiss(animated: true) {
      if let location = self.location,
         let address = self.address {
        self.completion(location, address)
      }

    }
  }
}

extension UIViewController {
  func showAddressViewController(completion: @escaping (CLLocation, String) -> Void) {
    let storyboard = UIStoryboard(name: "Profile", bundle: nil)
    let viewController =
    storyboard.instantiateViewController(withIdentifier: "address") as! AddressViewController

    viewController.completion = completion

    present(viewController, animated: true)
  }
}
