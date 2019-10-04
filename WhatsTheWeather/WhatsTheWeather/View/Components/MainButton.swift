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
        setGradientBackground(firstColor: GradientConstants.WTWFirstColor, secondColor: GradientConstants.WTWSecondColor)
        layer.cornerRadius = 10
        clipsToBounds = true
        titleLabel?.textColor = UIColor.white

    }
}

