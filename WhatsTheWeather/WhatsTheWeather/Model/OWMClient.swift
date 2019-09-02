//
//  OWMClient.swift
//  WhatsTheWeather
//
//  Created by Nael Awayes on 26/08/2019.
//  Copyright © 2019 Nael Awayes. All rights reserved.
//

//TODO: Chaining requests with PromiseKit seems interesting

//TODO: functions on steroids, needs refactoring

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
                    if response.statusCode == 200 {
                        let decoder = JSONDecoder()
                        do {
                            let weather = try decoder.decode(Weather.self, from: response.data)
                            completion(weather, nil)
                            return
                        } catch let error {
                            completion(nil, WeatherFetchError.parsingError(error))
                            return
                        }
                    }
                    if response.statusCode == 404 {
                        completion(nil, WeatherFetchError.notFoundError(nil))
                        return
                    }
                    let str = String(data: response.data, encoding: String.Encoding.utf8) as String?
                    completion(nil, WeatherFetchError.parsingError(nil))
                    return
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

    func getWeather5Day(searchString: String, units: OWMWeatherUnits, completion: @escaping (Weather5Day?, WeatherFetchError?) -> ()) {
        switch units {
        case .metric, .imperial:
            provider.request(.fiveDayForecast(searchString: searchString, appId: AppIds.OWM, units: units.rawValue)) { (result) in
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
                        let weather = try decoder.decode(Weather5Day.self, from: response.data)
                         let str = String(data: response.data, encoding: String.Encoding.utf8) as String?
                        completion(weather, nil)
                    } catch let error {
                        completion(nil, WeatherFetchError.parsingError(error))
                    }
                case .failure(let error):
                    completion(nil, WeatherFetchError.parsingError(error))
                }
            }
        case .kelvin:
            provider.request(.fiveDayForecast(searchString: searchString, appId: AppIds.OWM, units: nil)) { (result) in
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
                        let weather = try decoder.decode(Weather5Day.self, from: response.data)
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


    func getWeather5Day(location: Location, units: OWMWeatherUnits, completion: @escaping (Weather5Day?, WeatherFetchError?) -> ()) {
        switch units {
        case .metric, .imperial:
            provider.request(.fiveDayForecastLocation(latitude: location.latitude, longitude: location.longitude, appId: AppIds.OWM, units: units.rawValue)) { (result) in
                switch result {
                case .success(let response):
                    if response.statusCode == 200 {
                        let decoder = JSONDecoder()
                        do {
                            let weather = try decoder.decode(Weather5Day.self, from: response.data)
                            completion(weather, nil)
                            return
                        } catch let error {
                            dump(error)
                            completion(nil, WeatherFetchError.parsingError(error))
                            return
                        }
                    }
                    if response.statusCode == 404 {
                        completion(nil, WeatherFetchError.notFoundError(nil))
                        return
                    }
                    let str = String(data: response.data, encoding: String.Encoding.utf8) as String?
                    completion(nil, WeatherFetchError.parsingError(nil))
                    return
                case .failure(let error):
                    completion(nil, WeatherFetchError.parsingError(error))
                }
            }
        case .kelvin:
            provider.request(.fiveDayForecastLocation(latitude: location.latitude, longitude: location.longitude, appId: AppIds.OWM, units: nil)) { (result) in
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
                        let weather = try decoder.decode(Weather5Day.self, from: response.data)
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

    func getForecast(location: Location, units: OWMWeatherUnits, completion: @escaping (Forecast?, WeatherFetchError?) -> ()) {
        getWeather(location: location, units: units) { (weather, error) in
            if let error = error {
                completion(nil, error)
            }
            if let weather = weather {
                self.getWeather5Day(location: location, units: units, completion: { (weather5Day, error) in
                    if let error = error {
                        let forecast = Forecast(weather: weather, weather5days: nil)
                        completion(forecast, error)
                    }
                    if let weather5Day = weather5Day {
                        let forecast = Forecast(weather: weather, weather5days: weather5Day)
                        completion(forecast, nil)
                    }
                })
            }
        }
    }

    func getForecast(searchString: String, units: OWMWeatherUnits, completion: @escaping (Forecast?, WeatherFetchError?) -> ()) {
        getWeather(searchString: searchString, units: units) { (weather, error) in
            if let error = error {
                completion(nil, error)
            }
            if let weather = weather {
                self.getWeather5Day(searchString: searchString, units: units, completion: { (weather5Day, error) in
                    if let error = error {
                        let forecast = Forecast(weather: weather, weather5days: nil)
                        completion(forecast, error)
                    }
                    if let weather5Day = weather5Day {
                        let forecast = Forecast(weather: weather, weather5days: weather5Day)
                        completion(forecast, nil)
                    }
                })
            }
        }
    }

}
