//
//  FavoritesViewCell.swift
//  WhatsTheWeather
//
//  Created by Nael Awayes on 28/08/2019.
//  Copyright © 2019 Nael Awayes. All rights reserved.
//

import UIKit

final class FavoritesViewCell: UITableViewCell {
    @IBOutlet private weak var cityNameLabel: UILabel!

    @IBOutlet private weak var clippingView: UIView!

    @IBOutlet private weak var containerView: UIView!

    var cityName: String? {
        didSet {
            cityNameLabel.text = self.cityName
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        containerView.layer.shadowOpacity = 0.6
        containerView.layer.shadowRadius = 2
        containerView.layer.shadowOffset = CGSize(width: 3, height: 3)
        containerView.backgroundColor = UIColor.clear

        clippingView.layer.cornerRadius = 15
        clippingView.setGradientBackground(firstColor: UIColor(red:1.00, green:0.60, blue:0.40, alpha:1.0), secondColor: UIColor(red:1.00, green:0.37, blue:0.38, alpha:1.0))
        clippingView.clipsToBounds = true

        cityNameLabel.textColor = UIColor.white
        cityNameLabel.font = UIFont.boldSystemFont(ofSize: 17.0)
    }
}
