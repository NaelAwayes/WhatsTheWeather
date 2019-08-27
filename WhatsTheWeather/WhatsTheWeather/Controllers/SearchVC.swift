//
//  SearchVC.swift
//  WhatsTheWeather
//
//  Created by Nael Awayes on 26/08/2019.
//  Copyright © 2019 Nael Awayes. All rights reserved.
//

import UIKit
import FontAwesome_swift

class SearchVC: UIViewController {

    let client = OWMClient()
    var searchString: String = "" {
        didSet {
            //TODO: Implement Refresh History
        }
    }
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var locationButton: MainButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        navigationItem.title = "Search"
        navigationController?.navigationBar.prefersLargeTitles = true
        if let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField {
            textFieldInsideSearchBar.textColor = UIColor.white
        }
        let attributedTitle = NSMutableAttributedString(string: "Fetch weather using geolocation   ", attributes: nil)
        let attributedIcon = NSMutableAttributedString(string: String.fontAwesomeIcon(name: .locationArrow), attributes: [NSAttributedString.Key.font: UIFont.fontAwesome(ofSize: 15.0, style: .solid)])
        attributedTitle.append(attributedIcon)
        locationButton.setAttributedTitle(attributedTitle, for: .normal);
    }

}


extension SearchVC: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        var errorTitle: String?
        var errorDesc: String?
        guard let text = searchBar.text else { return }
        searchString = text
        client.getWeather(searchString: searchString, units: .metric) { (weather, error) in
            if let error = error {
                switch error {
                case .parsingError(_):
                    errorTitle = "A Technical Error Occured"
                    errorDesc = "Please retry later, or send a message to technical support"
                case .notFoundError(_):
                    errorTitle = "Could not find any results for your search"
                    errorDesc = "Please change your search query"
                }
                 let alert = UIAlertController(title: errorTitle, message: errorDesc, preferredStyle: .alert)
                alert.addAction(.init(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true)
            }
            dump(weather)
        }
    }
}
