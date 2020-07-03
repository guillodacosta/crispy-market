//
//  SearchInteractor.swift
//  crispy market
//
//  Created by guillermo on 6/28/20.
//  Copyright (c) 2020 guillodacosta. All rights reserved.
//

import Foundation

protocol SearchBusinessLogic {
    func fetchItems(request: Items.FetchItems.Request)
    func selectItem(_: Items.FetchItems.SimpleViewModel)
}

protocol SearchDataStore {
    var country: SelectCountries.SelectCountry.ViewModel? { get set }
    var itemsResponse: Items.FetchItems.Response? { get set }
    var itemViewModel: Items.FetchItems.SimpleViewModel? { get set }
}

class SearchInteractor: SearchBusinessLogic, SearchDataStore {
    var country: SelectCountries.SelectCountry.ViewModel?
    var itemsResponse: Items.FetchItems.Response?
    var itemViewModel: Items.FetchItems.SimpleViewModel?
    var presenter: SearchPresentationLogic
    private let marketApiWorker: SearchWorker
    private let countriesDataStore: SelectCountriesWorker
    
    init(presenter: SearchPresentationLogic, marketApiWorker: SearchWorker, countriesDataStore: SelectCountriesWorker) {
        self.presenter = presenter
        self.marketApiWorker = marketApiWorker
        self.countriesDataStore = countriesDataStore
        loadDefaultCountry()
    }
    
    func fetchItems(request: Items.FetchItems.Request) {
        if let country = country {
            let apiRequest = Items.FetchItems.Request(countryID: country.id,
                                                      query: request.query)
            marketApiWorker.fetchItems(request: apiRequest) { response, err in
                if let response = response {
                    self.itemsResponse = response
                    if response.results.count <= 0 {
                        self.presenter.presentEmptyItems()
                    } else {
                        self.presenter.presentItems(response: response)
                    }
                } else {
                    self.presenter.presentError(message: err?.rawMessage ?? "")
                }
            }
        } else {
            presenter.presentError(message: NSLocalizedString("SearchSceneErrorNoCountryOrigin", comment: " message error body"))
        }
    }
    
    func selectItem(_ item: Items.FetchItems.SimpleViewModel) {
        itemViewModel = item
        presenter.presentItem(viewModel: item)
    }
}

private extension SearchInteractor {
    
    func loadDefaultCountry() {
        countriesDataStore.retrieveUserCountry() { country, err  in
            if let country = country {
                self.country = country
            }
        }
    }
}

