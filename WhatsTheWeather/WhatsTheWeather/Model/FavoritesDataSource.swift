//
//  FavoritesModelController.swift
//  WhatsTheWeather
//
//  Created by Nael Awayes on 28/08/2019.
//  Copyright © 2019 Nael Awayes. All rights reserved.
//

import UIKit

class FavoritesDataSource: NSObject {
    var cityArray: [String]

    init(cityArray: [String]) {
        self.cityArray = cityArray.sorted(by: <)
    }
}

extension FavoritesDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: FavoritesViewCell.self), for: indexPath) as! FavoritesViewCell
        let cityName = cityArray[indexPath.row]
        cell.cityName = cityName
        return cell
    }
}
