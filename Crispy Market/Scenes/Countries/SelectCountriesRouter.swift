//
//  SelectCountriesRouter.swift
//  crispy market
//
//  Created by guillermo on 6/28/20.
//  Copyright (c) 2020 guillodacosta. All rights reserved.
//

import Foundation

protocol SelectCountriesRoutingLogic {
    func routeToSearch()
}

protocol SelectCountriesDataPassing {
    var dataStore: SelectCountriesDataStore { get }
}

class SelectCountriesRouter: NSObject, SelectCountriesRoutingLogic, SelectCountriesDataPassing {
    
    private weak var viewController: SelectCountriesViewController?
    var dataStore: SelectCountriesDataStore
    
    init(source viewController: SelectCountriesViewController, dataStore: SelectCountriesDataStore) {
        self.dataStore = dataStore
        self.viewController = viewController
    }
    
    func routeToSearch() {
        let destinationVC = SearchViewController()
        if let viewController = viewController {
            navigateToSearch(source: viewController, destination: destinationVC)
        }
    }
    
    private func navigateToSearch(source: SelectCountriesViewController, destination: SearchViewController) {
        source.show(destination, sender: nil)
    }
}
