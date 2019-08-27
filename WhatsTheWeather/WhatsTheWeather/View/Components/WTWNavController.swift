//
//  WTWNavController.swift
//  WhatsTheWeather
//
//  Created by Nael Awayes on 27/08/2019.
//  Copyright © 2019 Nael Awayes. All rights reserved.
//

import UIKit

final class WTWNavController: UINavigationController {

    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        self.commonSetup()
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);
        self.commonSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonSetup()
    }
}


private extension WTWNavController {
    func commonSetup() {
        navigationBar.setGradientBackgroundImage(startColor: UIColor(red:1.00, green:0.60, blue:0.40, alpha:1.0), endColor: UIColor(red:1.00, green:0.37, blue:0.38, alpha:1.0))
        navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    }
}
