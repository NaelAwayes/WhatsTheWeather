//
//  SearchVC.swift
//  WhatsTheWeather
//
//  Created by Nael Awayes on 26/08/2019.
//  Copyright © 2019 Nael Awayes. All rights reserved.
//

import UIKit
import FontAwesome_swift
import CoreLocation

class SearchVC: UIViewController {


    let locationManager = CLLocationManager() //TODO: Dependency injection would be better
    var userLocation: CLLocationCoordinate2D? {
        didSet {
            client.getWeather(location: Location(longitude: "\(self.userLocation?.longitude)", latitude: "\(self.userLocation?.latitude)"), units: .metric) { (weather, error) in
                if let error = error {
                    print("Location error fetch \(error)")
                }
                dump(weather)
            }
            locationManager.stopUpdatingLocation()
        }
    }

    let client = OWMClient()
    var searchString: String = "" {
        didSet {
            //TODO: Implement Refresh History
        }
    }
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var locationButton: MainButton!

    //TODO: Function not working without location dependency injection
//    func requestUserLocation() {
//        print(locationProvider)
//        locationProvider.findUserLocation { [weak self] location, error in
//            guard let self = self else { return }
//            if error == nil {
//                self.userLocation = location
//            } else {
//                print("User can not be located")
//            }
//        }
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        locationManager.delegate = self
        navigationItem.title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        if let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField {
            textFieldInsideSearchBar.textColor = UIColor.white
        }
        let attributedTitle = NSMutableAttributedString(string: "Fetch weather using geolocation   ", attributes: nil)
        let attributedIcon = NSMutableAttributedString(string: String.fontAwesomeIcon(name: .locationArrow), attributes: [NSAttributedString.Key.font: UIFont.fontAwesome(ofSize: 15.0, style: .solid)])
        attributedTitle.append(attributedIcon)
        locationButton.setAttributedTitle(attributedTitle, for: .normal);
    }

}

extension SearchVC: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let currentLocation = locations.last {
            userLocation = currentLocation.coordinate
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location Error: \(error)")
    }

    func requestUserLocation() {
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            return
        case .denied, .restricted:
            let alert = UIAlertController(title: "Location Services disabled", message: "Please enable location Services in Settings", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { action in
                UIApplication.shared.open(URL(string:UIApplication.openSettingsURLString)!)
            }
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            return
        case .authorizedAlways, .authorizedWhenInUse:
            break
        default:
            let alert = UIAlertController(title: "A technical error occurred", message: "Please get in touch with support so we can make sure this does not happen again.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
            return
        }
        locationManager.startUpdatingLocation()
    }
}

extension SearchVC {
    @IBAction func onLocationButtonTap(sender: UIButton, forEvent event: UIEvent) {
        requestUserLocation()
    }
}


extension SearchVC: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        var errorTitle: String?
        var errorDesc: String?
        guard let text = searchBar.text, text != "" else { return }
        searchString = text
        client.getWeather(searchString: searchString, units: .metric) { (weather, error) in
            if let error = error {
                switch error {
                case .parsingError(_):
                    errorTitle = "A Technical Error Occured"
                    errorDesc = "Please retry later, or send a message to technical support"
                case .notFoundError(_):
                    errorTitle = "Could not find any results for your search"
                    errorDesc = "Please change your search query"
                }
                 let alert = UIAlertController(title: errorTitle, message: errorDesc, preferredStyle: .alert)
                alert.addAction(.init(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
            dump(weather)
        }
    }
}
