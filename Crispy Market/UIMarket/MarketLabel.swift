//
//  MarketLabel.swift
//  crispy market
//
//  Created by guillermo on 6/28/20.
//  Copyright © 2020 guillodacosta. All rights reserved.
//

import UIKit

class MarketLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        textColor = #colorLiteral(red: 0.1568627451, green: 0.1960784314, blue: 0.4666666667, alpha: 1)
        font = UIFont(name: "Lato-Regular", size: 18)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MarketHeadline: UILabel {}

class MarketSubhead: UILabel {}

class MarketFootnote: UILabel {}
