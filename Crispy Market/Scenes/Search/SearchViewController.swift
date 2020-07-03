//
//  SearchViewController.swift
//  crispy market
//
//  Created by guillermo on 6/28/20.
//  Copyright (c) 2020 guillodacosta. All rights reserved.
//

import UIKit

typealias SimpleViewModel = Items.FetchItems.SimpleViewModel

protocol SearchDisplayLogic: class {
    func displayDetailView(viewModel: SimpleViewModel)
    func showEmptyState()
    func showError(message: String?)
    func showItems(viewModel: [SimpleViewModel])
}

class SearchViewController: UIViewController, SearchDisplayLogic {
    private var interactor: SearchBusinessLogic?
    private var router: (NSObjectProtocol & SearchRoutingLogic & SearchDataPassing)?
    
    private enum CellType {
        case empty
        case item(SimpleViewModel)
    }
    private var sections: [TableViewSection<CellType>] = []
    private let searchBar = UISearchBar()
    private let tableView = MarketTableView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpInjection()
        setUpConstraints()
        setUpView()
        showEmptyState()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    func displayDetailView(viewModel: SimpleViewModel) {
        router?.routeToItemDetails()
    }
    
    func showEmptyState() {
        sections = [TableViewSection(cells: [.empty])]
        tableView.separatorStyle = .none
        tableView.reloadData()
    }
    
    func showError(message: String?) {
        let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)

        alertController.addAction(UIAlertAction(title: NSLocalizedString("SearchSceneAlertCloseButton", comment: "close button title"), style: .cancel))
        
        present(alertController, animated: true)
    }
    
    func showItems(viewModel: [SimpleViewModel]) {
        sections = []
        viewModel.forEach { sections.append(TableViewSection(cells: [.item($0)])) }
        tableView.separatorStyle = .singleLine
        tableView.reloadData()
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
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
        switch sections[indexPath.section].cells[indexPath.row] {
        case .empty:
            let emptyCell: ItemEmptyCell = tableView.dequeueTypedCell(forIndexPath: indexPath)
            
            return emptyCell
        case .item(let viewModel):
            let itemCell: ItemViewCell = tableView.dequeueTypedCell(forIndexPath: indexPath)
            
            itemCell.initWith(viewModel: viewModel)
            itemCell.preservesSuperviewLayoutMargins = false
            itemCell.separatorInset = .zero
            itemCell.layoutMargins = .zero
            
            return itemCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch sections[indexPath.section].cells[indexPath.row] {
        case .item(let item): interactor?.selectItem(item)
        default: return
        } 
    }
}

extension SearchViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let query = searchBar.text {
            search(with: query)
        } else {
            search(with: "")
        }
    }
}

private extension SearchViewController {
    
    @objc func search(with query: String) {
        let request = Items.FetchItems.Request(countryID: nil, query: query)
        
        interactor?.fetchItems(request: request)
    }
    
    func setUpInjection() {
        let presenter = SearchPresenter(with: self)
        let countriesDataStore = SelectCountriesWorker(store: MarketDataStore())
        let marketApiworker = SearchWorker(store: MarketAPI())
        let interactor = SearchInteractor(presenter: presenter, marketApiWorker: marketApiworker, countriesDataStore: countriesDataStore)
        let router = SearchRouter(source: self, dataStore: interactor)
        
        self.interactor = interactor
        self.router = router
    }
    
    func setUpConstraints() {
        view.addSubview(searchBar)
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        let topSearchBar: NSLayoutConstraint
        if #available(iOS 11, *) {
            let guide = view.safeAreaLayoutGuide
            topSearchBar =        searchBar.topAnchor.constraint(equalToSystemSpacingBelow: guide.topAnchor, multiplier: 1.0)
        } else {
            topSearchBar = NSLayoutConstraint(item: searchBar, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 4)
        }
        let centerXSearchBar = NSLayoutConstraint(item: searchBar, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        let heightSearchBar = NSLayoutConstraint(item: searchBar, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.1, constant: 0)
        let widthSearchBar = NSLayoutConstraint(item: searchBar, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0)
        
        let bottomTableView = NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        let centerXTableView = NSLayoutConstraint(item: tableView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        let topTableView = NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: searchBar, attribute: .bottom, multiplier: 1, constant: 0)
        let widthTableView = NSLayoutConstraint(item: tableView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0)
        
        heightSearchBar.priority = .required
        NSLayoutConstraint.activate([centerXSearchBar, topSearchBar, heightSearchBar, widthSearchBar])
        NSLayoutConstraint.activate([centerXTableView, topTableView, bottomTableView, widthTableView])
    }
    
    func setUpView() {
        searchBar.delegate = self
        
        if let searchTextField = searchBar.value(forKey: "searchField") as? UITextField {
            searchTextField.textColor = #colorLiteral(red: 0.1568627451, green: 0.1960784314, blue: 0.4666666667, alpha: 1)
            searchTextField.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            searchTextField.layer.cornerRadius = 2
        }
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(ItemEmptyCell.self)
        tableView.register(ItemViewCell.self)
        tableView.estimatedRowHeight = view.bounds.width / 3
        tableView.separatorStyle = .none
        tableView.accessibilityIdentifier = "ItemsSearchTable"
    }
}
