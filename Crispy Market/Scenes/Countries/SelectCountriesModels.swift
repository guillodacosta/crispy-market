//
//  CountriesModels.swift
//  crispy market
//
//  Created by guillermo on 6/28/20.
//  Copyright (c) 2020 guillodacosta. All rights reserved.
//

enum SelectCountries {
    // MARK: Use cases
    
    enum FetchCountries {
        
        struct Response: Codable {
            
            let id: String
            let name: String
        }
        
        struct ViewModel {
            let id: String
            let name: String
        }
    }
    
    enum SelectCountry {
        
        struct ViewModel: Codable {
            let id: String
            let name: String
        }
    }
}
