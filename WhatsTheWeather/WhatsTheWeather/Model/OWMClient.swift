//
//  OWMClient.swift
//  WhatsTheWeather
//
//  Created by Nael Awayes on 26/08/2019.
//  Copyright © 2019 Nael Awayes. All rights reserved.
//

import Foundation
import Moya

class OWMClient: Networkable {
    var provider = MoyaProvider<OWMService>()


    func getWeather(location: Location, units: OWMWeatherUnits, completion: @escaping (Weather?, WeatherFetchError?) -> ()) {
        switch units {
        case .metric, .imperial:
            provider.request(.currentForecastLocation(latitude: location.latitude, longitude: location.longitude, appId: AppIds.OWM, units: units.rawValue)) { (result) in
                switch result {
                case .success(let response):
                    if response.statusCode == 404 {
                        completion(nil, WeatherFetchError.notFoundError(nil))
                    }
                    if response.statusCode == 400 {
                        completion(nil, WeatherFetchError.parsingError(nil))
                    }
                    let decoder = JSONDecoder()
                    do {
                        print(response.description)
                        let weather = try decoder.decode(Weather.self, from: response.data)
                        completion(weather, nil)
                    } catch let error {
                        completion(nil, WeatherFetchError.parsingError(error))
                    }
                case .failure(let error):
                    completion(nil, WeatherFetchError.parsingError(error))
                }
            }
        case .kelvin:
            provider.request(.currentForecastLocation(latitude: location.latitude, longitude: location.longitude, appId: AppIds.OWM, units: nil)) { (result) in
                switch result {
                case .success(let response):
                    if response.statusCode == 404 {
                        completion(nil, WeatherFetchError.notFoundError(nil))
                    }
                    if response.statusCode == 400 {
                        completion(nil, WeatherFetchError.parsingError(nil))
                    }
                    let decoder = JSONDecoder()
                    do {
                        let weather = try decoder.decode(Weather.self, from: response.data)
                        completion(weather, nil)
                    } catch let error {
                        completion(nil, WeatherFetchError.parsingError(error))
                    }
                case .failure(let error):
                    completion(nil, WeatherFetchError.parsingError(error))
                }
            }
        }
    }

    func getWeather(searchString: String, units: OWMWeatherUnits, completion: @escaping (Weather?, WeatherFetchError?) -> ()) {
        switch units {
        case .metric, .imperial:
            provider.request(.currentForecast(searchString: searchString, appId: AppIds.OWM, units: units.rawValue)) { (result) in
                switch result {
                case .success(let response):
                    if response.statusCode == 404 {
                        completion(nil, WeatherFetchError.notFoundError(nil))
                    }
                    if response.statusCode == 400 {
                        completion(nil, WeatherFetchError.parsingError(nil))
                    }
                    let decoder = JSONDecoder()
                    do {
                        print(response.description)
                        let weather = try decoder.decode(Weather.self, from: response.data)
                        completion(weather, nil)
                    } catch let error {
                        completion(nil, WeatherFetchError.parsingError(error))
                    }
                case .failure(let error):
                    completion(nil, WeatherFetchError.parsingError(error))
                }
            }
        case .kelvin:
            provider.request(.currentForecast(searchString: searchString, appId: AppIds.OWM, units: nil)) { (result) in
                switch result {
                case .success(let response):
                    if response.statusCode == 404 {
                        completion(nil, WeatherFetchError.notFoundError(nil))
                    }
                    if response.statusCode == 400 {
                        completion(nil, WeatherFetchError.parsingError(nil))
                    }
                    let decoder = JSONDecoder()
                    do {
                        let weather = try decoder.decode(Weather.self, from: response.data)
                        completion(weather, nil)
                    } catch let error {
                        completion(nil, WeatherFetchError.parsingError(error))
                    }
                case .failure(let error):
                    completion(nil, WeatherFetchError.parsingError(error))
                }
            }
        }
    }
}
