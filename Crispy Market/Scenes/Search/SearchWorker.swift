//
//  SearchWorker.swift
//  crispy market
//
//  Created by guillermo on 6/28/20.
//  Copyright (c) 2020 guillodacosta. All rights reserved.
//

import Foundation

protocol SearchProtocol {
    func fetchItems(request: Items.FetchItems.Request, completionHandler: @escaping (_ response: Items.FetchItems.Response?, SearchError?) -> Void)
}

class SearchWorker {
    let store: SearchProtocol
    
    init(store: SearchProtocol) {
        self.store = store
    }
    
    func fetchItems(request: Items.FetchItems.Request, completionHandler: @escaping (_ response: Items.FetchItems.Response?, SearchError?) -> Void) {
        store.fetchItems(request: request) { items, err in
            completionHandler(items, err)
        }
    }
}

enum SearchError: Equatable, Error {
    case CannotFetch(String)
    
    var rawMessage: String {
        switch self {
        case .CannotFetch(let message):
            return message
        }
    }
}
