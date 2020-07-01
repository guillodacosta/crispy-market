//
//  CountryViewCell.swift
//  crispy market
//
//  Created by guillermo on 6/28/20.
//  Copyright (c) 2020 guillodacosta. All rights reserved.
//

import UIKit

class CountryViewCell: UITableViewCell {

    private let nameLabel = MarketLabel(frame: .zero)
    
    private var country: SelectCountries.FetchCountries.ViewModel? {
        didSet {
            updateUI()
        }
    }
    
    func initWith(viewModel: SelectCountries.FetchCountries.ViewModel) {
        country = viewModel
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension CountryViewCell {
    
    func setUpConstraints() {
        addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let centerYNameLabel = NSLayoutConstraint(item: nameLabel, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0)
        let heightNameLabel = NSLayoutConstraint(item: nameLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 50)
        let leadingNameLabel = NSLayoutConstraint(item: nameLabel, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 20)
        let trailingNameLabel = NSLayoutConstraint(item: nameLabel, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 20)
        
        NSLayoutConstraint.activate([leadingNameLabel, centerYNameLabel, trailingNameLabel, heightNameLabel])
        
    }
    
    func updateUI() {
        nameLabel.text = country?.name
    }
}
