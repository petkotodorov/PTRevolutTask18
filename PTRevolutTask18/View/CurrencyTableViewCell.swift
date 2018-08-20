//
//  CurrencyTableViewCell.swift
//  PTRevolutTask18
//
//  Created by Petko Todorov on 8/17/18.
//  Copyright © 2018 Petko Todorov. All rights reserved.
//

import UIKit

protocol CurrencyCellDelegate: class {
    func didSetBaseValue(_ baseValue: Double)
}

class CurrencyTableViewCell: UITableViewCell {
    
    weak var delegate: CurrencyCellDelegate?
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        return label
    }()
    
    let amountTextField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        textField.textAlignment = .right
        textField.keyboardType = .decimalPad
        textField.placeholder = "0.00"
        return textField
    }()
    
    let amountSeparatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layoutViews()
        amountTextField.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func layoutViews() {
        addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        nameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3, constant: 0).isActive = true
        
        addSubview(amountTextField)
        amountTextField.translatesAutoresizingMaskIntoConstraints = false
        amountTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        amountTextField.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        amountTextField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 10).isActive = true
        
        addSubview(amountSeparatorView)
        amountSeparatorView.translatesAutoresizingMaskIntoConstraints = false
        amountSeparatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        amountSeparatorView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12).isActive = true
        amountSeparatorView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        amountSeparatorView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.3).isActive = true
    }
    
    
}

extension CurrencyTableViewCell: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        amountSeparatorView.backgroundColor = UIColor.customBlue
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        amountSeparatorView.backgroundColor = .lightGray
    }
    
    /**
     Checks:
     -if the decimal separator is only one
     -if the decimal separatot is "," or "."
     -if the number of digits after the separator are max 2
     -if the number of all symbols is max 8
     */
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let oldText = textField.text, let r = Range(range, in: oldText) else {
            return true
        }
        
        let newText = oldText.replacingCharacters(in: r, with: string)
        let numberOfDots = newText.components(separatedBy: ".").count - 1
        let numberOfComas = newText.components(separatedBy: ",").count - 1
        
        let numberOfDecimalDigits: Int
        if let dotIndex = newText.index(of: ".") {
            numberOfDecimalDigits = newText.distance(from: dotIndex, to: newText.endIndex) - 1
        } else if let comaIndex = newText.index(of: ",") {
            numberOfDecimalDigits = newText.distance(from: comaIndex, to: newText.endIndex) - 1
        } else {
            numberOfDecimalDigits = 0
        }
        if numberOfDots <= 1 && numberOfComas <= 1 && numberOfDecimalDigits <= 2 && newText.count <= 8 {
            let value = newText.count == 0 ? 0 : newText.doubleValue
            delegate?.didSetBaseValue(value)
            return true
        }
        return false
    }
}

