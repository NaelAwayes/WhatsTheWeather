//
//  ForecastViewCell.swift
//  WhatsTheWeather
//
//  Created by Nael Awayes on 02/09/2019.
//  Copyright © 2019 Nael Awayes. All rights reserved.
//

import UIKit

final class ForecastViewCell: UICollectionViewCell {
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var hourLabel: UILabel!
    @IBOutlet private weak var tempButton: TemperatureButton!

    var hour: String? {
        didSet {
            hourLabel.text = hour
        }
    }

    var temp: Double = 0 {
        didSet {
            tempButton.temperature = temp
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()

        containerView.layer.cornerRadius = 15
        containerView.setGradientBackground(firstColor: GradientConstants.WTWFirstColor, secondColor: GradientConstants.WTWSecondColor)
        containerView.clipsToBounds = true
        hourLabel.textColor = UIColor.white
    }
}
