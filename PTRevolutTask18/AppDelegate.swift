//
//  AppDelegate.swift
//  PTRevolutTask18
//
//  Created by Petko Todorov on 8/14/18.
//  Copyright © 2018 Petko Todorov. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        
        let viewModel = CurrencyListViewModel(withApiClient: ApiClient())
        let currencyListController = CurrencyListViewController(withViewModel: viewModel)
        currencyListController.title = "Revolut"
        let navController = UINavigationController(rootViewController: currencyListController)
        window?.rootViewController = navController
        
        return true
    }


}

