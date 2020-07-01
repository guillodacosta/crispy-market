//
//  MarketFormatExtension.swift
//  crispy market
//
//  Created by guillermo on 6/28/20.
//  Copyright © 2020 guillodacosta. All rights reserved.
//

import Foundation

extension Float {
    ///
    /// Formats the current float into a currency
    /// - returns: string dollar amount
    ///
    var asCurrencyString: String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency

        guard let price = formatter.string(from: NSNumber(value: self.round(toPlaces: 2))) else { return nil }
        
        let formattedPrice = price.replacingOccurrences(of: ".00", with: "", options: .literal, range: nil)

        return formattedPrice
    }

    /// Rounds the double to decimal places value
    public func round(toPlaces: Int) -> Float {
        let divisor = pow(10.0, Float(toPlaces))
        return (self * divisor).rounded() / divisor
    }
}
