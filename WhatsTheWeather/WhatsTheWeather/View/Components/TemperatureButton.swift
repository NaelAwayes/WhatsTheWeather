//
//  TemperatureButton.swift
//  WhatsTheWeather
//
//  Created by Nael Awayes on 28/08/2019.
//  Copyright © 2019 Nael Awayes. All rights reserved.
//

import UIKit

final class TemperatureButton: UIButton {
    private enum Constants {
        static let height: CGFloat = 50.0
    }

    var temperature: Double = 0 {
        didSet {
            self.setTitle("\(String(format: "%.1f", temperature)) \(symbol)", for: .normal)
        }
    }

    private var symbol: String = "°C"

    var isCelcius: Bool = true {
        didSet {
            if (isCelcius == true) {
                symbol = "°C"
            } else {
                symbol = "°F"
            }
        }
    }

    public convenience init() {
        self.init(frame: .zero)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonSetup()
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonSetup()
    }

    public override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        commonSetup()
    }

    override public func layoutSubviews() {
        super.layoutSubviews()
        commonSetup()
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isCelcius {
            isCelcius = !isCelcius
            temperature = convertCelsiusToFahrenheit(celsius: temperature)
        } else {
            isCelcius = !isCelcius
            temperature = convertFahrenheitToCelsius(fahrenheit: temperature)
        }
    }
}

private extension TemperatureButton {
    func commonSetup() {
        tintColor = UIColor.white
        titleLabel?.font = UIFont.systemFont(ofSize: 17.0)
    }

    func convertCelsiusToFahrenheit(celsius: Double) -> Double {
        return (celsius * 9/5) + 32
    }

    func convertFahrenheitToCelsius(fahrenheit: Double) -> Double {
        return (fahrenheit - 32) * 5/9
    }
}
