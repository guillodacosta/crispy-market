//
//  SearchPresenter.swift
//  crispy market
//
//  Created by guillermo on 6/28/20.
//  Copyright (c) 2020 guillodacosta. All rights reserved.
//


protocol SearchPresentationLogic {
    func presentEmptyItems()
    func presentError(message: String?)
    func presentItem(viewModel: Items.FetchItems.SimpleViewModel)
    func presentItems(response: Items.FetchItems.Response)
}

class SearchPresenter: SearchPresentationLogic {
    
    weak var viewController: SearchDisplayLogic?
    
    init(with viewController: SearchDisplayLogic) {
        self.viewController = viewController
    }
    
    func presentEmptyItems() {
        viewController?.showEmptyState()
    }
    
    func presentError(message: String?) {
        viewController?.showError(message: message)
    }
    
    func presentItem(viewModel: Items.FetchItems.SimpleViewModel) {
        viewController?.displayDetailView(viewModel: viewModel)
    }
    
    func presentItems(response: Items.FetchItems.Response) {
        let viewModel = response.results.map {
            Items.FetchItems.SimpleViewModel(id: $0.id, title: $0.title, seller: $0.seller, price: $0.price, currencyID: $0.currencyID, availableQuantity: $0.availableQuantity, soldQuantity: $0.soldQuantity, buyingMode: $0.buyingMode, thumbnail: $0.thumbnail, acceptsMercadopago: $0.acceptsMercadopago, installments: $0.installments, address: $0.address, shipping: $0.shipping, attributes: $0.attributes, originalPrice: $0.originalPrice, categoryID: $0.categoryID)
        }
        viewController?.showItems(viewModel: viewModel)
    }
}
