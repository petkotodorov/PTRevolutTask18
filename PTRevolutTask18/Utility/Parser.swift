//
//  Parser.swift
//  PTRevolutTask18
//
//  Created by Petko Todorov on 8/19/18.
//  Copyright © 2018 Petko Todorov. All rights reserved.
//

import Foundation

struct Parser {
    
    static func parseDataIntoCurrencies(_ data: Data) -> [Currency] {
        var currencies = [Currency]()
        
        do {
            if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                if let base = json["base"] as? String {
                    let baseCurrency = Currency(name: base, exchangeRate: 1.0)
                    currencies.append(baseCurrency)
                }
                if let rates = json["rates"] as? [String: Double] {
                    rates.keys.forEach {
                        if let value = rates[$0] {
                            let currency = Currency(name: $0, exchangeRate: value)
                            currencies.append(currency)
                        }
                    }
                }
            }
        } catch {
        }
        
        return currencies
    }
    
}
