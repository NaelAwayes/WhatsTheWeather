//
//  MainButton.swift
//  WhatsTheWeather
//
//  Created by Nael Awayes on 26/08/2019.
//  Copyright © 2019 Nael Awayes. All rights reserved.
//

import UIKit

@IBDesignable
class MainButton: UIButton {
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var textLabel: UILabel!
    @IBOutlet private weak var iconLabel: UILabel!

    public var text: String = "" {
        didSet {
            textLabel.text = self.text
        }
    }

    public var icon: String = "" {
        didSet {
            iconLabel.text = self.icon
        }
    }

    let gradientLayer = CAGradientLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.customInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.customInit()
    }

    private func customInit() {
        Bundle.main.loadNibNamed("MainButton", owner: self, options: nil)

        self.addSubview(self.contentView)
        self.drawBackgroundGradient(colors: [UIColor(hex: "#800080"), UIColor(hex: "#ffc0cb")])
        self.contentView.frame = self.bounds
        self.contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
}

private extension MainButton {
    func drawBackgroundGradient(colors: [UIColor?]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
}

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat

        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])

            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0

                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255

                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }

        return nil
    }
}
