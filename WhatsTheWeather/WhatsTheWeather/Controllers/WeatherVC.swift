//
//  WeatherVC.swift
//  WhatsTheWeather
//
//  Created by Nael Awayes on 28/08/2019.
//  Copyright © 2019 Nael Awayes. All rights reserved.
//

import UIKit

final class WeatherVC: UIViewController {

    var currentWeather: Weather?
    var weather5Day: Weather5Day?
    var forecastDataSource = ForecastDataSource(forecast: [])

    @IBOutlet private weak var currentTempButton: TemperatureButton!

//    @IBOutlet private weak var iconWeather: UIImageView!

    @IBOutlet private weak var windSpeedLabel: UILabel!
    @IBOutlet private weak var windDirLabel: UILabel!

    @IBOutlet private weak var pressureLabel: UILabel!
    @IBOutlet private weak var humidityLabel: UILabel!

    @IBOutlet private weak var forecastCollectionView: UICollectionView!

    var favoriteStatus: Bool = false {
        didSet {
            if favoriteStatus {
                self.navigationItem.rightBarButtonItem = createRemoveCityBarButton()
            } else {
                self.navigationItem.rightBarButtonItem = createAddCityBarButton()
            }
//            print(UserDefaults.standard.stringArray(forKey: "savedCityArray"))
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let forecastCellNib = UINib(nibName: "ForecastViewCell", bundle: nil)
        forecastCollectionView.register(forecastCellNib, forCellWithReuseIdentifier: "ForecastViewCell")

        forecastCollectionView.delegate = self
        var forecast = [List]()
        if let list = weather5Day?.list {
            for i in 0...4 {
                if list.indices.contains(i) {
                    forecast.append(list[i])
                }
            }
        }
        forecastDataSource.forecast = forecast
        forecastCollectionView.dataSource = forecastDataSource
        forecastCollectionView.contentInset.left = 20
        self.navigationController?.navigationBar.tintColor = UIColor.white
        navigationItem.title = "Weather"
        
        favoriteStatus = checkIfCityInSavedList()
        setupWeatherInfo()
    }
}

extension WeatherVC: UICollectionViewDelegate {

}

private extension WeatherVC {
    func setupWeatherInfo() {
        currentTempButton.temperature = currentWeather?.main?.temp ?? 0
        windSpeedLabel.text = "\(String(format: "%.3f", currentWeather?.wind?.speed ?? "No wind speed data available")) m/s"
        windDirLabel.text = "\(String(format: "%.3f", currentWeather?.wind?.deg ?? "No wind direction data available")) °"
        pressureLabel.text = "\(String(format: "%.1f", currentWeather?.main?.pressure ?? "No pressure data available")) hPa"
        humidityLabel.text = "\(String(format: "%.1f", currentWeather?.main?.humidity ?? "No humidity data available")) %"
        if let cityName = currentWeather?.name, let countryName = currentWeather?.sys?.country {
            navigationItem.title = "\(cityName), \(countryName)"
        }
        dump(weather5Day)
    }

    @objc func addCityToFavorites() {
        guard let cityName = currentWeather?.name else {
           displayAlert(title: "An Error Occurred", message: "Please get in touch with support so can we make sure this does not happen again", alertActionTitle: "OK")
            return
        }
        if var cityArray = UserDefaults.standard.stringArray(forKey: "savedCityArray") {
            if (cityArray.contains(cityName)) {
                displayAlert(title: "City already in Favorites", message:"The current city already exists in your list of saved cities", alertActionTitle: "OK")
                return
            }
            cityArray.append(cityName)
            UserDefaults.standard.set(cityArray, forKey: "savedCityArray")
            favoriteStatus = true
        } else {
            let cityArray = [cityName]
            UserDefaults.standard.set(cityArray, forKey: "savedCityArray")
            favoriteStatus = true
        }
    }
    
    func displayAlert(title: String?, message: String?, alertActionTitle: String?, handler: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: alertActionTitle, style: .default, handler: handler)
        alert.addAction(action)
        self.present(alert, animated: true, completion: nil)
    }

    @objc func removeCityFromFavorites() {
        guard let cityName = currentWeather?.name else {
            displayAlert(title: "An Error Occurred", message: "Please get in touch with support so can we make sure this does not happen again", alertActionTitle: "OK")
            return
        }
        if var cityArray = UserDefaults.standard.stringArray(forKey: "savedCityArray") {
            if (cityArray.contains(cityName)) {
                cityArray.removeAll { (value) -> Bool in
                    value == cityName
                }
                UserDefaults.standard.set(cityArray, forKey: "savedCityArray")
                favoriteStatus = false
                return
            }
        }
         displayAlert(title: "City not in Favorites", message:"The current city does not exist in your list of saved cities", alertActionTitle: "OK")
        return
    }

    func checkIfCityInSavedList() -> Bool {
        guard let cityName = currentWeather?.name, let cityArray = UserDefaults.standard.stringArray(forKey: "savedCityArray") else { return false }
        if cityArray.contains(cityName) { return true } else { return false }
    }

    func createAddCityBarButton() -> UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCityToFavorites))
    }

    func createRemoveCityBarButton() -> UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(removeCityFromFavorites))
    }
}
