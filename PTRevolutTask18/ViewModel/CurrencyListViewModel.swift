//
//  CurrencyListViewModel.swift
//  PTRevolutTask18
//
//  Created by Petko Todorov on 8/19/18.
//  Copyright © 2018 Petko Todorov. All rights reserved.
//

import Foundation

class CurrencyListViewModel {
    
    private var timer: Timer?
    private let repeatInterval: TimeInterval = 1
    
    private let apiClient: ApiClient
    
    var baseValue: Double = 1 {
        didSet {
            reloadTableViewClosure?()
        }
    }
    private var baseCurrency: Currency? {
        didSet {
            if let name = baseCurrency?.name, let currentValue = currencyValues[name] {
                baseValue = currentValue
            }
            fetchRates()
        }
    }
    
    var allCurrencies = [Currency]()
    private var currencyValues = [String: Double]()
    
    var alertMessage: String? {
        didSet {
            showAlertClosure?()
        }
    }
    
    var showAlertClosure: (()->())?
    var reloadTableViewClosure: (()->())?

    
    init(withApiClient apiClient: ApiClient) {
        self.apiClient = apiClient
        setTimer()
    }
    
    private func setTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: repeatInterval, repeats: true) { [weak self] (_) in
            self?.fetchRates()
        }
        timer?.fire()
    }
    
    private func fetchRates() {
        apiClient.fetchRates(forBaseCurrency: baseCurrency?.name) { [weak self] (result) -> (Void) in
            switch result {
            case .success(let data):
                self?.updateDataSource(withNewRates: Parser.parseDataIntoCurrencies(data))
            case .failure(let errMessage):
                self?.alertMessage = errMessage
            }
        }
    }
    
    //If there are currencies already fetched, just update exchange rates
    private func updateDataSource(withNewRates currencies: [Currency]) {
        if allCurrencies.isEmpty {
            allCurrencies = currencies
        } else {
            allCurrencies.forEach({ (currency) in
                if let first = currencies.first(where: { (foundCurrency) -> Bool in
                    foundCurrency == currency
                }) {
                    let index = (self.allCurrencies.index(of: currency))!
                    self.allCurrencies[index].exchangeRate = first.exchangeRate
                }
            })
        }
        reloadTableViewClosure?()
    }
    
    //MARK: TableView data
    
    func currenciesCount() -> Int {
        return allCurrencies.count
    }
    
    func currencyNameForIndex(_ index: Int) -> String {
        return allCurrencies[index].name
    }
    
    func currencyValueForIndex(_ index: Int) -> String {
        let currency = allCurrencies[index]
        let value = currency.exchangeRate * baseValue
        currencyValues[currency.name] = value
        return String(format: "%.2f", value)
    }
    
    func moveRow(at: Int, to: Int) {
        allCurrencies.rearrange(from: at, to: to)
        baseCurrency = allCurrencies[0]
    }
    
}
