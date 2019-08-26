//
//  Networkable.swift
//  WhatsTheWeather
//
//  Created by Nael Awayes on 26/08/2019.
//  Copyright © 2019 Nael Awayes. All rights reserved.
//

import Foundation
import Moya

protocol Networkable {
    var provider: MoyaProvider<OWMService> { get }

    func getWeather(searchString: String, units: OWMWeatherUnits, completion: @escaping (Weather?, WeatherFetchError?) -> ())
}
