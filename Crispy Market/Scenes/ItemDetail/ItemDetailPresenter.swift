//  ItemDetailPresenter.swift
//  crispy market
//
//  Created by guillermo on 6/28/20.
//  Copyright (c) 2020 guillodacosta. All rights reserved.
//

import Foundation

protocol ItemDetailPresentationLogic {
    func presentItem(viewModel: Items.FetchItems.SimpleViewModel)
}

class ItemDetailPresenter: ItemDetailPresentationLogic {
    
    weak var viewController: ItemDetailDisplayLogic?
    
    init(with viewController: ItemDetailDisplayLogic) {
        self.viewController = viewController
    }
    
    func presentItem(viewModel: Items.FetchItems.SimpleViewModel) {
        viewController?.displayDetailView(viewModel: viewModel)
    }
}
