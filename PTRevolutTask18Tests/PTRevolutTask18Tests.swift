//
//  PTRevolutTask18Tests.swift
//  PTRevolutTask18Tests
//
//  Created by Petko Todorov on 8/14/18.
//  Copyright © 2018 Petko Todorov. All rights reserved.
//

import XCTest
@testable import PTRevolutTask18

class PTRevolutTask18Tests: XCTestCase {
    
    var viewModel: CurrencyListViewModel = CurrencyListViewModel(withApiClient: ApiClient())
    
    override func setUp() {
        super.setUp()
        let currencies = [Currency(name: "EUR", exchangeRate: 1),
                          Currency(name: "USD", exchangeRate: 2.5),
                          Currency(name: "BGN", exchangeRate: 3),
                          Currency(name: "RUB", exchangeRate: 4)]
        viewModel.allCurrencies = currencies
    }
    
    override func tearDown() {
        viewModel.allCurrencies.removeAll()
    }
    
    func testCount() {
        XCTAssertTrue(viewModel.currenciesCount() == 4)
    }
    
    func testNames() {
        XCTAssertTrue(viewModel.currencyNameForIndex(0) == "EUR")
        XCTAssertTrue(viewModel.currencyNameForIndex(1) == "USD")
        XCTAssertTrue(viewModel.currencyNameForIndex(2) == "BGN")
        XCTAssertTrue(viewModel.currencyNameForIndex(3) == "RUB")
    }
    
    func testValues() {
        XCTAssertTrue(viewModel.currencyValueForIndex(0) == "1.00")
        XCTAssertTrue(viewModel.currencyValueForIndex(1) == "2.50")
        XCTAssertTrue(viewModel.currencyValueForIndex(2) == "3.00")
        XCTAssertTrue(viewModel.currencyValueForIndex(3) == "4.00")
    }
    
    func testChangedBaseValue() {
        viewModel.baseValue = 2
        XCTAssertTrue(viewModel.currencyValueForIndex(0) == "2.00")
        XCTAssertTrue(viewModel.currencyValueForIndex(1) == "5.00")
        XCTAssertTrue(viewModel.currencyValueForIndex(2) == "6.00")
        XCTAssertTrue(viewModel.currencyValueForIndex(3) == "8.00")
    }
    
    func testRearrangedNames() {
        viewModel.moveRow(at: 2, to: 0)
        XCTAssertTrue(viewModel.currencyNameForIndex(0) == "BGN")
        XCTAssertTrue(viewModel.currencyNameForIndex(1) == "EUR")
        XCTAssertTrue(viewModel.currencyNameForIndex(2) == "USD")
        XCTAssertTrue(viewModel.currencyNameForIndex(3) == "RUB")
    }
    
}
