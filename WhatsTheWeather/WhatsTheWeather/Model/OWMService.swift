//
//  OWMService.swift
//  WhatsTheWeather
//
//  Created by Nael Awayes on 26/08/2019.
//  Copyright © 2019 Nael Awayes. All rights reserved.
//

import Moya

enum OWMService {
    case currentForecast(searchString: String, appId: String, units: String?)
}

extension OWMService: TargetType {
    var baseURL: URL {
        switch self {
        case .currentForecast:
            return URL(string: "https://api.openweathermap.org/data/2.5/")!
        }
    }

    var path: String {
        switch self {
        case .currentForecast:
            return "/weather"
        }
    }

    var method: Method {
        switch self {
        case .currentForecast:
            return .get
        }
    }

    var sampleData: Data {
        return Data()
    }

    var task: Task {
        switch self {
        case let .currentForecast(searchString, appId, units):
            if let units = units {
                return .requestParameters(parameters: ["q": searchString, "appid": appId, "units": units], encoding: URLEncoding.queryString)
            } else {
                return .requestParameters(parameters: ["q": searchString, "appid": appId], encoding: URLEncoding.queryString)
            }
        }
    }

    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }

}
