//
//  ReusableView.swift
//  PTRevolutTask18
//
//  Created by Petko Todorov on 8/15/18.
//  Copyright © 2018 Petko Todorov. All rights reserved.
//

import Foundation

protocol ReusableView {
    
    static var reuseIdentifier: String { get }
    
}

extension ReusableView {
    
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
}
