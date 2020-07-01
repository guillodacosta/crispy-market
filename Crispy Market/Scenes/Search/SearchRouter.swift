//
//  SearchRouterRouter.swift
//  crispy market
//
//  Created by guillermo on 6/28/20.
//  Copyright (c) 2020 guillodacosta. All rights reserved.
//

import UIKit

@objc protocol SearchRoutingLogic {
    func routeToItemDetails()
}

protocol SearchDataPassing {
    var dataStore: SearchDataStore { get set }
}

class SearchRouter: NSObject, SearchRoutingLogic, SearchDataPassing {
    weak var viewController: SearchViewController?
    var dataStore: SearchDataStore
    
    init(source viewController: SearchViewController, dataStore: SearchDataStore) {
        self.dataStore = dataStore
        self.viewController = viewController
    }
    
    func routeToItemDetails() {
        let destinationVC = ItemDetailViewController()
            
        destinationVC.initializeComponents()
        if let destinationDataStore = pushDestinationData(source: dataStore, destination: destinationVC.router?.dataStore) {
            destinationVC.router?.dataStore = destinationDataStore
            navigateToItemDetail(destination: destinationVC)
        }
    }
    
    func navigateToItemDetail(destination: ItemDetailViewController) {
        viewController?.navigationController?.navigationBar.isHidden = false
        viewController?.navigationController?.pushViewController(destination, animated: true)
    }
    
    private func pushDestinationData(source: SearchDataStore, destination dest: ItemDetailDataStore?) -> ItemDetailDataStore? {
        var destination = dest
        
        destination?.itemViewModel = source.itemViewModel
        
        return destination
    }
}
