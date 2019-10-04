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
        navigationBar.setGradientBackgroundImage(startColor: GradientConstants.WTWFirstColor, endColor: GradientConstants.WTWSecondColor)
        navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
    }
}

final class WTWTabController: UITabBarController {

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.commonSetup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonSetup()
    }
}

private extension WTWTabController {
    func commonSetup() {
        tabBar.setGradientBackground(firstColor: GradientConstants.WTWFirstColor, secondColor: GradientConstants.WTWSecondColor)
        tabBar.unselectedItemTintColor = UIColor.darkGray
        tabBar.tintColor = UIColor.white
    }
}

