//
//  Favorite.swift
//  WhatsTheWeather
//
//  Created by Nael Awayes on 28/08/2019.
//  Copyright © 2019 Nael Awayes. All rights reserved.
//

import Foundation

struct Favorite {
    let weather: Weather?
    let error: WeatherFetchError?
    let cityName: String
}
