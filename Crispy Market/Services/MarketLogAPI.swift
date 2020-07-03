//
//  MarketLogAPI.swift
//  crispy market
//
//  Created by guillermo on 7/3/20.
//  Copyright © 2020 guillodacosta. All rights reserved.
//

import os

protocol MarketLogsProtocol {
    func debug(message: String)
    func error(error: Error)
    func error(message: String)
}

protocol MarketCrashLogProtocol {
    func log(error: Error)
    func log(message: String)
}

//: NSObject,
class MarketLogAPI: MarketLogsProtocol {
    
    var debugging: Bool
    private let additionalInfo = "addionalInfo"
    private let logCrash: MarketCrashLogProtocol?
    
    init(debugging: Bool = false, logCrash: MarketCrashLogProtocol? = nil) {
        self.debugging = debugging
        self.logCrash = logCrash
    }
    
    func debug(message: String) {
        if (!debugging) { return }
        os_log("%@", type: .debug, message)
    }
    
    func error(error: Error) {
        if (debugging) { return }
        logCrash?.log(error: error)
    }
    
    func error(message: String) {
        if (!debugging) { return }
        os_log("%@", type: .error, message)
        logCrash?.log(message: message)
    }
}
