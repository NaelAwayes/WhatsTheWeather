//
//  MainButton.swift
//  WhatsTheWeather
//
//  Created by Nael Awayes on 26/08/2019.
//  Copyright © 2019 Nael Awayes. All rights reserved.
//

import UIKit
import FontAwesome_swift
import TinyConstraints

@IBDesignable
final class MainButton: UIButton {
    private enum Constants {
        static let height: CGFloat = 50.0
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
}

private extension MainButton {

    func commonSetup() {
        height(Constants.height)
//        let gradientColor1 = UIColor(red: 128, green: 0, blue: 128, alpha: 255)
//        let gradientColor2 = UIColor(red: 255, green: 192, blue: 203, alpha: 255)
        let gradientColor1 = UIColor(red:1.00, green:0.60, blue:0.40, alpha:1.0)
        let gradientColor2 = UIColor(red:1.00, green:0.37, blue:0.38, alpha:1.0)
        setGradientBackground(firstColor: gradientColor1, secondColor: gradientColor2)
        layer.cornerRadius = 10
        clipsToBounds = true
        titleLabel?.textColor = UIColor.white

    }
}

