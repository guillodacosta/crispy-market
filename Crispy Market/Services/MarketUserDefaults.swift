//
//  MarketDataStore.swift
//  crispy market
//
//  Created by guillermo on 6/28/20.
//  Copyright © 2020 guillodacosta. All rights reserved.
//

import Foundation

public class MarketDataStore {
    
    let defaults = UserDefaults.standard
}

extension MarketDataStore: SelectCountriesProtocol {
    
    func fetchCountries(completionHandler: @escaping ([SelectCountries.FetchCountries.Response]?, SelectCountriesError?) -> Void) {}
    
    func retrieveUserCountry(completionHandler: @escaping(_ country: SelectCountries.SelectCountry.ViewModel?, SelectCountriesError?) -> Void) {
        do {
            if let data =  UserDefaults.standard.data(forKey: KeyMarketDataStore.userCountry.rawValue) {
                let country = try JSONDecoder().decode(SelectCountries.SelectCountry.ViewModel.self, from: data)
                completionHandler(country, nil)
            } else {
                completionHandler(nil, SelectCountriesError.CannotFetch(NSLocalizedString("MarketLocalAPIErrorParseData", comment: "error local API message")))
            }
        } catch {
            completionHandler(nil, SelectCountriesError.CannotFetch(NSLocalizedString("MarketLocalAPIErrorNoData", comment: "error local API message")))
        }
    }
    
    func saveUserCountry(country: SelectCountries.SelectCountry.ViewModel, completionHandler: @escaping (SelectCountries.SelectCountry.ViewModel?, SelectCountriesError?) -> Void) {
        do {
            let data = try JSONEncoder().encode(country)
            UserDefaults.standard.set(data, forKey: KeyMarketDataStore.userCountry.rawValue)
            completionHandler(country, nil)
        } catch {
            debugPrint(error)
            completionHandler(nil, SelectCountriesError.CannotFetch(NSLocalizedString("MarketLocalAPIErrorCannotSave", comment: "error local API message")))
        }
    }
}

enum KeyMarketDataStore: String {
    case userCountry = "userCountry"
}
