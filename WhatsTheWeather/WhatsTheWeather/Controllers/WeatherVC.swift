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

    @IBOutlet private weak var currentTempButton: TemperatureButton!

//    @IBOutlet private weak var iconWeather: UIImageView!

    @IBOutlet private weak var windSpeedLabel: UILabel!
    @IBOutlet private weak var windDirLabel: UILabel!

    @IBOutlet private weak var pressureLabel: UILabel!
    @IBOutlet private weak var humidityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        navigationItem.title = "Weather"
        setupWeatherInfo()
    }
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
    }
}
