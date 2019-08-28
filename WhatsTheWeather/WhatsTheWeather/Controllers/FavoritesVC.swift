//
//  FavoritesVC.swift
//  WhatsTheWeather
//
//  Created by Nael Awayes on 28/08/2019.
//  Copyright © 2019 Nael Awayes. All rights reserved.
//

import UIKit

class FavoritesVC: UIViewController {

    @IBOutlet private weak var tableView: UITableView!

    override func viewDidLoad() {
        tableView.delegate = self
        self.navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Favorites"
    }
}

extension FavoritesVC: UITableViewDelegate {
    
}
