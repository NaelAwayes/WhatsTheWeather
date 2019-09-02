//
//  ForecastDataSource.swift
//  WhatsTheWeather
//
//  Created by Nael Awayes on 02/09/2019.
//  Copyright © 2019 Nael Awayes. All rights reserved.
//

import UIKit

class ForecastDataSource: NSObject {
    var forecast: [List]

    init(forecast: [List]) {
        self.forecast = forecast
    }
}

extension ForecastDataSource: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecast.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String.init(describing: ForecastViewCell.self), for: indexPath) as! ForecastViewCell
        guard let dt = forecast[indexPath.row].dt, let temp = forecast[indexPath.row].main?.temp else {
            return cell
        }
        let timeInterval = Double(dt)
        let hour = Date(timeIntervalSince1970: timeInterval)
        let df = DateFormatter()
        df.dateFormat = "HH:mm"
        cell.hour = df.string(from: hour)
        cell.temp = temp
        return cell
    }
}
