//
//  SelectCountriesViewController.swift
//  crispy market
//
//  Created by guillermo on 6/28/20.
//  Copyright (c) 2020 guillodacosta. All rights reserved.
//

import UIKit

protocol SelectCountriesDisplayLogic: class {
    func displayHome()
    func showCountries(viewModel: [SelectCountries.FetchCountries.ViewModel])
}

class SelectCountriesViewController: UIViewController, SelectCountriesDisplayLogic {
    private var interactor: SelectCountriesBusinessLogic?
    private var router: (NSObjectProtocol & SelectCountriesRoutingLogic & SelectCountriesDataPassing)?
    
    private var countries: [SelectCountries.FetchCountries.ViewModel] = []
    private let headerView = MarketView()
    private let tableView = MarketTableView(frame: .zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpInjection()
        setUpConstraints()
        setUpView()
        loadAvailableCountries()
    }
    
    func displayHome() {
        router?.routeToSearch()
    }
    
    func showCountries(viewModel: [SelectCountries.FetchCountries.ViewModel]) {
        countries = viewModel
        tableView.reloadData()
    }
}

extension SelectCountriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let country = countries[indexPath.row]
        let countryCell: CountryViewCell = tableView.dequeueTypedCell(forIndexPath: indexPath)
        
        countryCell.initWith(viewModel: country)
        countryCell.preservesSuperviewLayoutMargins = false
        countryCell.separatorInset = .zero
        countryCell.layoutMargins = .zero

        return countryCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let country = SelectCountries.SelectCountry.ViewModel(
            id: countries[indexPath.row].id,
            name: countries[indexPath.row].name
        )
        
        selectCountry(country)
    }
}

private extension SelectCountriesViewController {
    
    func selectCountry(_ country: SelectCountries.SelectCountry.ViewModel) {
        interactor?.selectCountry(country)
    }
    
    func setUpInjection() {
        let presenter = SelectCountriesPresenter(with: self)
        let marketDataStore = SelectCountriesWorker(store: MarketDataStore())
        let marketApiworker = SelectCountriesWorker(store: MarketAPI())
        let interactor = SelectCountriesInteractor(presenter: presenter, marketApiWorker: marketApiworker, marketCoreDataWorker: marketDataStore)
        let router = SelectCountriesRouter(source: self, dataStore: interactor)
        
        self.interactor = interactor
        self.router = router
    }
    
    func setUpConstraints() {
        view.addSubview(headerView)
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        headerView.translatesAutoresizingMaskIntoConstraints = false
        let centerXHeaderView = NSLayoutConstraint(item: headerView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        let heightHeaderView = NSLayoutConstraint(item: headerView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 0.1, constant: 0)
        heightHeaderView.priority = .required
        let topHeaderView = NSLayoutConstraint(item: headerView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1, constant: 0)
        let widthHeaderView = NSLayoutConstraint(item: headerView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0)
        
        let bottomTableView = NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        let centerXTableView = NSLayoutConstraint(item: tableView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0)
        let topTableView = NSLayoutConstraint(item: tableView, attribute: .top, relatedBy: .equal, toItem: headerView, attribute: .bottom, multiplier: 1, constant: 0)
        let widthTableView = NSLayoutConstraint(item: tableView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0)
        
        NSLayoutConstraint.activate([centerXHeaderView, topHeaderView, heightHeaderView, widthHeaderView])
        NSLayoutConstraint.activate([centerXTableView, topTableView, bottomTableView, widthTableView])
    }
    
    func setUpView() {
        headerView.backgroundColor = #colorLiteral(red: 1, green: 0.9019607843, blue: 0, alpha: 1)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CountryViewCell.self)
        tableView.accessibilityIdentifier = "AvailableCountryTable"
    }
    
    func loadAvailableCountries() {
        interactor?.loadAvailableCountries()
    }
    
}
