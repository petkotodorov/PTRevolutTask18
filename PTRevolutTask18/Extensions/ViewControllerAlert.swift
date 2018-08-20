//
//  ViewControllerAlert.swift
//  PTRevolutTask18
//
//  Created by Petko Todorov on 8/19/18.
//  Copyright © 2018 Petko Todorov. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showAlert(withTitle title: String = "Error",
                   withMessage message: String,
                   defaultButtonTitle buttonTitle: String = "OK",
                   buttonCallback callback: ((UIAlertAction) -> Void)? = nil) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: callback))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
