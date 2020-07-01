//
//  SelectCountriesWorker.swift
//  crispy market
//
//  Created by guillermo on 6/28/20.
//  Copyright (c) 2020 guillodacosta. All rights reserved.
//

import Foundation

protocol SelectCountriesProtocol {
    func fetchCountries(completionHandler: @escaping (_ countries: [SelectCountries.FetchCountries.Response]?, SelectCountriesError?) -> Void)
    
    func retrieveUserCountry(completionHandler: @escaping(_ country: SelectCountries.SelectCountry.ViewModel?, SelectCountriesError?) -> Void)
    
    func saveUserCountry(country: SelectCountries.SelectCountry.ViewModel, completionHandler: @escaping(_ country: SelectCountries.SelectCountry.ViewModel?, SelectCountriesError?) -> Void)
}

class SelectCountriesWorker {
    let store: SelectCountriesProtocol
    
    init(store: SelectCountriesProtocol) {
        self.store = store
    }
    
    func fetchCountries(completionHandler: @escaping (_ countries: [SelectCountries.FetchCountries.Response]?, SelectCountriesError?) -> Void) {
        store.fetchCountries { countries, err in
            completionHandler(countries, err)
        }
    }
    
    func retrieveUserCountry(completionHandler: @escaping(_ country: SelectCountries.SelectCountry.ViewModel?, SelectCountriesError?) -> Void) {
        store.retrieveUserCountry { country, err in
            completionHandler(country, err)
        }
    }
    
    func saveCountry(country: SelectCountries.SelectCountry.ViewModel, completionHandler: @escaping(_ country: SelectCountries.SelectCountry.ViewModel?, SelectCountriesError?) -> Void) {
        store.saveUserCountry(country: country, completionHandler: { savedCountry, err  in
            completionHandler(savedCountry, err)
        })
    }
}

enum SelectCountriesError: Equatable, Error {
    case CannotFetch(String)
    
    var rawMessage: String {
        switch self {
        case .CannotFetch(let message):
            return message
        }
    }
}
