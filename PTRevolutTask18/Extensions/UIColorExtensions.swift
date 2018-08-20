//
//  UIColorExtensions.swift
//  PTRevolutTask18
//
//  Created by Petko Todorov on 8/20/18.
//  Copyright © 2018 Petko Todorov. All rights reserved.
//

import UIKit

extension UIColor {
    
    static var customGreen: UIColor {
        return UIColor.rgba(red: 27, green: 186, blue: 176, alpha: 1)
    }
    
    static var customOrange: UIColor {
        return UIColor.rgba(red: 255, green: 87, blue: 34, alpha: 1)
    }
    
    static var customBlue: UIColor {
        return UIColor.rgba(red: 67, green: 165, blue: 251, alpha: 1)
    }
    
    static func rgba(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
}
