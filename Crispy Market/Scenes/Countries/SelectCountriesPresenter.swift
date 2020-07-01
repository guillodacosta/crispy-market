//
//  SelectCountriesPresenter.swift
//  crispy market
//
//  Created by guillermo on 6/28/20.
//  Copyright (c) 2020 guillodacosta. All rights reserved.
//


protocol SelectCountriesPresentationLogic {
    func presentCountries(response: [SelectCountries.FetchCountries.Response])
    func presentSearchView()
}

class SelectCountriesPresenter: SelectCountriesPresentationLogic {
    private weak var viewController: SelectCountriesDisplayLogic?
    
    init(with viewController: SelectCountriesDisplayLogic) {
        self.viewController = viewController
    }
    
    func presentCountries(response: [SelectCountries.FetchCountries.Response]) {
        let viewModel = response.map({
            SelectCountries.FetchCountries.ViewModel(id: $0.id, name: $0.name)
        })
        
        viewController?.showCountries(viewModel: viewModel)
    }
    
    func presentSearchView() {
        viewController?.displayHome()
    }
}
