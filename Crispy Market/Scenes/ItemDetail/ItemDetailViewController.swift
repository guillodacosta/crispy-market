//
//  ItemDetailViewController.swift
//  crispy market
//
//  Created by guillermo on 6/28/20.
//  Copyright (c) 2020 guillodacosta. All rights reserved.
//

import UIKit
import SnapKit

protocol ItemDetailDisplayLogic: class {
    func displayDetailView(viewModel: Items.FetchItems.SimpleViewModel)
}

class ItemDetailViewController: UIViewController, ItemDetailDisplayLogic {
    
    private var interactor: ItemDetailBusinessLogic?
    var router: (NSObjectProtocol & ItemDetailRoutingLogic & ItemDetailDataPassing)?
    
    private enum CellType {
        case general(String)
        case image(String)
        case name(String)
        case price(Float)
    }
    private var sections: [TableViewSection<CellType>] = []
    private let tableView = MarketTableView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpConstraints()
        setUpView()
        interactor?.loadItem()
    }
    
    func initializeComponents() {
        setUpInjection()
    }
    
    func displayDetailView(viewModel: Items.FetchItems.SimpleViewModel) {
        sections = [
            TableViewSection(cells: [.image(viewModel.thumbnail ?? "")]),
            TableViewSection(cells: [.name(viewModel.title ?? "")]),
            TableViewSection(cells: [.price(viewModel.price ?? 0.0)]),
            TableViewSection(cells: [.price(viewModel.originalPrice ?? 0.0)]),
        ]
        tableView.reloadData()
    }
}

extension ItemDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].cells.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        UIView(frame: .zero)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.rowHeight = UIDevice.current.orientation.isLandscape ? view.bounds.height / 6 : view.bounds.width / 4
        switch sections[indexPath.section].cells[indexPath.row] {
        case .general(let title):
            let itemCell: GeneralViewCell = tableView.dequeueTypedCell(forIndexPath: indexPath)
            
            itemCell.initWith(title: title)
            
            return itemCell
        case .image(let url):
            let itemCell: ImageViewCell = tableView.dequeueTypedCell(forIndexPath: indexPath)
            
            tableView.rowHeight = UIDevice.current.orientation.isLandscape ? view.bounds.height / 2 : view.bounds.width * 0.75
            itemCell.initWith(url: url)
            
            return itemCell
        case .name(let title):
            let itemCell: TitleViewCell = tableView.dequeueTypedCell(forIndexPath: indexPath)
            
            itemCell.initWith(title: title)
            
            return itemCell
        case .price(let value):
            let itemCell: ValueViewCell = tableView.dequeueTypedCell(forIndexPath: indexPath)
            
            itemCell.initWith(value: value)
            
            return itemCell
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        tableView.reloadData()
    }
    
}

private extension ItemDetailViewController {
    
    func setUpInjection() {
        let presenter = ItemDetailPresenter(with: self)
        let interactor = ItemDetailInteractor(presenter: presenter)
        let router = ItemDetailRouter(source: self, dataStore: interactor)

        self.interactor = interactor
        self.router = router
    }
    
    func setUpConstraints() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.height.equalTo(view.snp.height)
            make.left.equalTo(view.snp.left)
            make.top.equalTo(view.snp.top)
            make.width.equalTo(view.snp.width)
        }
    }
    
    func setUpView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(GeneralViewCell.self)
        tableView.register(ImageViewCell.self)
        tableView.register(TitleViewCell.self)
        tableView.register(ValueViewCell.self)
        tableView.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        tableView.estimatedRowHeight = UIDevice.current.orientation.isLandscape ? view.bounds.height / 6 : view.bounds.width / 4
        tableView.separatorStyle = .none
        tableView.separatorStyle = .none
        tableView.accessibilityIdentifier = "ItemDetailTable"
    }
}
