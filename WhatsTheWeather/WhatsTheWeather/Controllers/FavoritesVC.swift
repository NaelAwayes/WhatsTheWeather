//
//  FavoritesVC.swift
//  WhatsTheWeather
//
//  Created by Nael Awayes on 28/08/2019.
//  Copyright © 2019 Nael Awayes. All rights reserved.
//

import UIKit
import TinyConstraints

class FavoritesVC: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    let favoritesDataSource: FavoritesDataSource = FavoritesDataSource(cityArray: getFavorites())
    let client = OWMClient()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.dataSource = favoritesDataSource
        tableView.reloadData()
        self.navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Favorites"

        let favoritesCellNib = UINib(nibName: "FavoritesViewCell", bundle: nil)
        tableView.register(favoritesCellNib, forCellReuseIdentifier: "FavoritesViewCell")
        checkIfTableViewEmpty()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favoritesDataSource.cityArray = FavoritesVC.getFavorites()
        tableView.reloadData()
        checkIfTableViewEmpty()
    }

    static func getFavorites() -> [String] {
        guard let cityArray = UserDefaults.standard.stringArray(forKey: "savedCityArray") else { return [] }
        return cityArray
    }
}

extension FavoritesVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorites = FavoritesVC.getFavorites()
        var errorTitle: String?
        var errorDesc: String?
        if favorites.indices.contains(indexPath.row) {
            client.getForecast(searchString: favorites[indexPath.row], units: .metric) { (forecast, error) in
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
                dump(forecast?.weather5days)
                self.navigateToWeatherScreen(weather: forecast?.weather, weather5Day: forecast?.weather5days)
            }
        } else {
            errorTitle = "A Technical Error Occured"
            errorDesc = "Please retry later, or send a message to technical support"
            let alert = UIAlertController(title: errorTitle, message: errorDesc, preferredStyle: .alert)
            alert.addAction(.init(title: "OK", style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
}

private extension FavoritesVC {
    func navigateToWeatherScreen(weather: Weather?, weather5Day: Weather5Day? = nil) {
        let weatherVC = WeatherVC.instantiate(fromAppStoryboard: .WeatherPage)
        weatherVC.currentWeather = weather
        weatherVC.weather5Day = weather5Day
        self.show(weatherVC, sender: nil)
    }

    func checkIfTableViewEmpty() {
        if tableView.visibleCells.isEmpty {
            let label = UILabel()
            label.text = "You don't have any city saved."
            label.textColor = UIColor.white
            label.textAlignment = .center
            tableView.backgroundView = label
        } else {
            tableView.backgroundView = nil
        }
    }
}
