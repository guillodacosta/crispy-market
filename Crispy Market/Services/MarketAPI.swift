//
//  MarketAPI.swift
//  crispy market
//
//  Created by guillermo on 6/28/20.
//  Copyright © 2020 guillodacosta. All rights reserved.
//

import Foundation
import Alamofire

public class MarketAPI {}

extension MarketAPI: SearchProtocol {
    func fetchItems(request: Items.FetchItems.Request, completionHandler: @escaping (Items.FetchItems.Response?, SearchError?) -> Void) {
        let params = [
            "q": request.query
        ]
        
        if let countryId = request.countryID {
            let url = "https://api.mercadolibre.com/sites/\(String(describing: countryId))/search"
            
            AF.request(url, parameters: params).response { response in
                switch(response.result) {
                case .success(_):
                    if let data = response.data {
                        do {
                            let items = try JSONDecoder().decode(Items.FetchItems.Response.self, from: data)
                            completionHandler(items, nil)
                        } catch {
                            completionHandler(nil, SearchError.CannotFetch("Houston hay problemas!"))
                        }
                    } else {
                        completionHandler(nil, SearchError.CannotFetch("Houston no hay nada!"))
                    }
                    break
                case .failure(let error as NSError):
                    debugPrint(error.localizedDescription)
                    completionHandler(nil, SearchError.CannotFetch(error.localizedDescription))
                    break
                }
            }
        }
    }
}

extension MarketAPI: SelectCountriesProtocol {
      
    func fetchCountries(completionHandler: @escaping (_ countries: [SelectCountries.FetchCountries.Response]?, SelectCountriesError?) -> Void) {

        AF.request("https://api.mercadolibre.com/sites").response { response in
            switch(response.result) {
            case .success(_):
                if let data = response.data {
                    do {
                        let countries = try JSONDecoder().decode([SelectCountries.FetchCountries.Response].self, from: data)
                        completionHandler(countries, nil)
                    } catch {
                        completionHandler(nil, SelectCountriesError.CannotFetch("Houston hay problemas!"))
                    }
                } else {
                    completionHandler(nil, SelectCountriesError.CannotFetch("Houston no hay nada!"))
                }
                break
            case .failure(let error as NSError):
                debugPrint(error.localizedDescription)
                completionHandler(nil, SelectCountriesError.CannotFetch("Houston hay problemas!"))
                break
            }
        }
    }
    
    func retrieveUserCountry(completionHandler: @escaping(_ country: SelectCountries.SelectCountry.ViewModel?, SelectCountriesError?) -> Void) {}
    
    func saveUserCountry(country: SelectCountries.SelectCountry.ViewModel, completionHandler: @escaping (SelectCountries.SelectCountry.ViewModel?, SelectCountriesError?) -> Void) {}
}

