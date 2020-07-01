//
//  ItemsViewController.swift
//  crispy market
//
//  Created by guillermo on 6/28/20.
//  Copyright (c) 2020 guillodacosta. All rights reserved.
//

import UIKit

protocol ItemsDisplayLogic: class {
//    func showItems(viewModel: Items.Item.ViewModel)
}

class SearchViewController: UIViewController, ItemsDisplayLogic {
//    var interactor: ItemsBusinessLogic?
//    var router: (NSObjectProtocol & ItemsRoutingLogic & ItemsDataPassing)?
    
//    @IBOutlet weak var <#name#>TextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        getItems()
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
//    func showItems(viewModel: Items.Item.ViewModel) {
//        //<#name#>TextField.text = viewModel.<#prop#>
//    }
}

private extension SearchViewController {
    
    private func setup() {
//        let presenter = ItemsPresenter(with: self)
//        let worker = ItemsWorker()
//        let interactor = ItemsInteractor(presenter: presenter, worker: worker)
//        let router = ItemsRouter(source: self, dataStore: interactor)
//
//        self.interactor = interactor
//        self.router = router
    }
    
    func getItems() {
//        let request = Items.Item.Request()
//        interactor?.getItems(request: request)
    }
    
}
