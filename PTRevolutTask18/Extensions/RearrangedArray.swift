//
//  RearrangedArray.swift
//  PTRevolutTask18
//
//  Created by Petko Todorov on 8/19/18.
//  Copyright © 2018 Petko Todorov. All rights reserved.
//

import Foundation

extension Array {
    
    //rearranges an element of array to a new position
    mutating func rearrange(from: Int, to: Int) {
        guard !self.isEmpty,
            from >= 0,
            from < self.count,
            to >= 0,
            to < self.count else { return }
        insert(remove(at: from), at: to)
    }
    
}
