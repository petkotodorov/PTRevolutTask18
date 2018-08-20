//
//  ReusableTableViewCell.swift
//  PTRevolutTask18
//
//  Created by Petko Todorov on 8/15/18.
//  Copyright © 2018 Petko Todorov. All rights reserved.
//

import UIKit

extension UITableViewCell: ReusableView {}

extension UITableView {
    
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue reusable table view cell")
        }
        return cell
    }
    
}
