//
//  Currency.swift
//  PTRevolutTask18
//
//  Created by Petko Todorov on 8/16/18.
//  Copyright © 2018 Petko Todorov. All rights reserved.
//

import Foundation

struct Currency: Equatable {
    let name: String
    var exchangeRate: Double
    
    public static func == (lhs: Currency, rhs: Currency) -> Bool {
        return lhs.name == rhs.name
    }
}
