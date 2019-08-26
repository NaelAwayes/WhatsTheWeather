//
//  SearchVC.swift
//  WhatsTheWeather
//
//  Created by Nael Awayes on 26/08/2019.
//  Copyright © 2019 Nael Awayes. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    let client = OWMClient()
    var searchString: String = "" {
        didSet {
            //TODO: Implement Refresh History
        }
    }
    @IBOutlet private weak var searchBar: UISearchBar!

    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        self.navigationItem.title = "Search"
        self.navigationController?.navigationBar.prefersLargeTitles = true
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
