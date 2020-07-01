//
//  SelectCountryInteractor.swift
//  crispy market
//
//  Created by guillermo on 6/28/20.
//  Copyright (c) 2020 guillodacosta. All rights reserved.
//

protocol SelectCountriesBusinessLogic {
    func loadAvailableCountries()
    func selectCountry(_ country: SelectCountries.SelectCountry.ViewModel)
}

protocol SelectCountriesDataStore {
    var countries: [SelectCountries.FetchCountries.Response]? { get set }
    var country: SelectCountries.SelectCountry.ViewModel? { get set }
}

class SelectCountriesInteractor: SelectCountriesBusinessLogic, SelectCountriesDataStore {
    var countries: [SelectCountries.FetchCountries.Response]?
    var country: SelectCountries.SelectCountry.ViewModel?
    private let presenter: SelectCountriesPresentationLogic
    private let marketApiWorker: SelectCountriesWorker
    private let marketUserDefaultsWorker: SelectCountriesWorker
    
    init(presenter: SelectCountriesPresentationLogic, marketApiWorker: SelectCountriesWorker, marketCoreDataWorker: SelectCountriesWorker) {
        self.presenter = presenter
        self.marketApiWorker = marketApiWorker
        self.marketUserDefaultsWorker = marketCoreDataWorker
    }
    
    func loadAvailableCountries() {
        marketApiWorker.fetchCountries { countries, err  in
            self.countries = countries
            if let countries = countries {
                self.presenter.presentCountries(response: countries)
            }
        }
    }
    
    func selectCountry(_ country: SelectCountries.SelectCountry.ViewModel) {
        marketUserDefaultsWorker.saveCountry(country: country) { countrySaved, err -> Void in
            if let country = countrySaved {
                self.country = country
                self.presenter.presentSearchView()
            }
        }
    }
}
