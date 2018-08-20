//
//  StringExtensions.swift
//  PTRevolutTask18
//
//  Created by Petko Todorov on 8/19/18.
//  Copyright © 2018 Petko Todorov. All rights reserved.
//

import Foundation

extension String {
    var doubleValue: Double {
        let formatter = NumberFormatter()
        formatter.decimalSeparator = "."
        if let result = formatter.number(from: self) {
            return result.doubleValue
        } else {
            formatter.decimalSeparator = ","
            if let result = formatter.number(from: self) {
                return result.doubleValue
            }
        }
        return 0
    }
}
