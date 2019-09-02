// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let weather5Day = try? newJSONDecoder().decode(Weather5Day.self, from: jsonData)

import Foundation

// MARK: - Weather5Day
struct Weather5Day: Codable {
    let list: [List]?
}

// MARK: - List
struct List: Codable {
    let dt: Int?
    let main: MainClass?
    let dtTxt: String?

    enum CodingKeys: String, CodingKey {
        case dt, main
        case dtTxt = "dt_txt"
    }
}

// MARK: - MainClass
struct MainClass: Codable {
    let temp: Double?

    enum CodingKeys: String, CodingKey {
        case temp
    }
}
