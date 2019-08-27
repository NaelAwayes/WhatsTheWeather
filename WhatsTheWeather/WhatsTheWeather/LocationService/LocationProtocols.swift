//
//  UserLocation.swift
//  WhatsTheWeather
//
//  Created by Nael Awayes on 27/08/2019.
//  Copyright © 2019 Nael Awayes. All rights reserved.
//

import Foundation
import CoreLocation

typealias Coordinate = CLLocationCoordinate2D

protocol UserLocation {
    var location: Location { get }
}
//
//extension CLLocation: UserLocation {
//    var location: Location {
//        <#code#>
//    }
//}

enum UserLocationError: Swift.Error {
    case canNotBeLocated
}

typealias UserLocationCompletionBlock = (UserLocation?, UserLocationError?) -> Void

protocol UserLocationProvider {
    func findUserLocation(then: @escaping UserLocationCompletionBlock)
}

protocol LocationProvider {
    var isUserAuthorized: Bool { get }
    func requestWhenInUseAuthorization()
    func requestLocation()
}

extension CLLocationManager: LocationProvider {
    var isUserAuthorized: Bool {
        return CLLocationManager.authorizationStatus() == .authorizedWhenInUse
    }
}
