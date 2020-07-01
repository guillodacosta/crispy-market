//
//  MarketTableView.swift
//  crispy market
//
//  Created by guillermo on 6/28/20.
//  Copyright © 2020 guillodacosta. All rights reserved.
//

import UIKit

class MarketTableView: UITableView {}

open class TableViewSection<CellEnum> {
    public var cells: [CellEnum]

    public init(cells: [CellEnum] = []) {
        self.cells = cells
    }
}
