//
//  ItemDetailRouter.swift
//  crispy market
//
//  Created by guillermo on 6/28/20.
//  Copyright (c) 2020 guillodacosta. All rights reserved.
//

import Foundation

protocol ItemDetailRoutingLogic {
    func routeToSearch()
}

protocol ItemDetailDataPassing {
    var dataStore: ItemDetailDataStore { get set }
}

class ItemDetailRouter: NSObject, ItemDetailRoutingLogic, ItemDetailDataPassing {
    weak var viewController: ItemDetailViewController?
    var dataStore: ItemDetailDataStore
    
    init(source viewController: ItemDetailViewController, dataStore: ItemDetailDataStore) {
        self.dataStore = dataStore
        self.viewController = viewController
    }
    
    func routeToSearch() {
        viewController?.navigationController?.popViewController(animated: true)
    }
}

