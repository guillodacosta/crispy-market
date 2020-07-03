//
//  BuildType.swift
//  crispy market
//
//  Created by guillermo on 7/3/20.
//  Copyright © 2020 guillodacosta. All rights reserved.
//

struct BuildType {
    
    private static let debug : Bool = {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }()
    
    static func isDebug () -> Bool {
        return self.debug
    }
    
}
