//
//  ViewController.swift
//  PTRevolutTask18
//
//  Created by Petko Todorov on 8/14/18.
//  Copyright © 2018 Petko Todorov. All rights reserved.
//

import UIKit

class CurrencyListViewController: UITableViewController {
    
    private let viewModel: CurrencyListViewModel
    
    init(withViewModel viewModel: CurrencyListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        setupViewModel()
    }
    
    private func configureTableView() {
        tableView.register(CurrencyTableViewCell.self, forCellReuseIdentifier: CurrencyTableViewCell.reuseIdentifier)
        tableView.keyboardDismissMode = .onDrag
        tableView.separatorStyle = .none
    }
    
    private func setupViewModel() {
        viewModel.reloadTableViewClosure = { [weak self] () in
            self?.reloadValues()
        }
        viewModel.showAlertClosure = { [weak self] () in
            if let message = self?.viewModel.alertMessage {
                self?.showAlert(withMessage: message)
            }
        }
    }
    
    private func reloadValues() {
        var indexPaths = self.tableView.indexPathsForVisibleRows
        indexPaths = indexPaths?.filter {
            $0.row != 0
        }
        guard let visibleIndexPaths = indexPaths, visibleIndexPaths.count > 0 else {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            return
        }
        DispatchQueue.main.async {
            visibleIndexPaths.forEach {
                if let cell = self.tableView.cellForRow(at: $0) as? CurrencyTableViewCell {
                    cell.amountTextField.text = self.viewModel.currencyValueForIndex($0.row)
                }
            }
        }
    }

}

extension CurrencyListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.currenciesCount()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CurrencyTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.delegate = self
        cell.nameLabel.text = viewModel.currencyNameForIndex(indexPath.row)
        cell.amountTextField.text = viewModel.currencyValueForIndex(indexPath.row)
        cell.amountTextField.isUserInteractionEnabled = indexPath.row == 0 ? true : false
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard indexPath.row != 0 else { return }
        let firstRowIndexPath = IndexPath(row: 0, section: 0)
        
        tableView.moveRow(at: indexPath, to: firstRowIndexPath)
        tableView.scrollToRow(at: firstRowIndexPath, at: .top, animated: true)
        viewModel.moveRow(at: indexPath.row, to: firstRowIndexPath.row)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if let firstCell = tableView.cellForRow(at: firstRowIndexPath) as? CurrencyTableViewCell {
                firstCell.amountTextField.isUserInteractionEnabled = true
                firstCell.amountTextField.becomeFirstResponder()
            }
            
            if let secondCell = tableView.cellForRow(at: IndexPath(row: 1, section: 0)) as? CurrencyTableViewCell {
                secondCell.amountTextField.isUserInteractionEnabled = false
            }
        }
        
    }
    
}

extension CurrencyListViewController: CurrencyCellDelegate {
    
    func didSetBaseValue(_ baseValue: Double) {
        self.viewModel.baseValue = baseValue
    }
    
}

