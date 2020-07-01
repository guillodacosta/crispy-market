//
//  ItemDetailInteractor.swift
//  crispy market
//
//  Created by guillermo on 6/28/20.
//  Copyright © 2020 guillodacosta. All rights reserved.
//

protocol ItemDetailBusinessLogic {
    func loadItem()
}

protocol ItemDetailDataStore {
    var itemViewModel: Items.FetchItems.SimpleViewModel? { get set }
}

class ItemDetailInteractor: ItemDetailBusinessLogic, ItemDetailDataStore {
    var itemViewModel: Items.FetchItems.SimpleViewModel?
    var presenter: ItemDetailPresentationLogic
    
    init(presenter: ItemDetailPresentationLogic) {
        self.presenter = presenter
    }
    
    func loadItem() {
        if let itemViewModel = itemViewModel {
            presenter.presentItem(viewModel: itemViewModel)
        }
    }
}

