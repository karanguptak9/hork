//
//  CryptoTableCell.swift
//  hork
//
//  Created by Karan Gupta on 4/15/18.
//  Copyright © 2018 Karan Gupta. All rights reserved.
//

import Foundation
import UIKit
        //concetrating on each cell activity and updating
class CryptoTableViewCell: UITableViewCell {
        //each button initiated
    @IBOutlet weak var currencyImageView: UIImageView!
    @IBOutlet weak var currencyName: UILabel!
    @IBOutlet weak var currencyPrice: UILabel!
        //need cell format and request value
    func formatCell(withCurrencyType currencyType: CurrencyType) {
        currencyName.text = currencyType.name
        currencyImageView.image = currencyType.image
        
        currencyType.requestValue { (value) in
            DispatchQueue.main.async {
                guard let value = value else {
                    self.currencyPrice.text = "Failed to get price"
                    return
                }
                self.currencyPrice.text = value.formattedCurrencyString
            }
        }
    }
}

private extension NSNumber {
        // Takes NSNumber and converts it to USD String
    var formattedCurrencyString: String? {
        // Create a NumberFormatter that uses the currency style
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US")
        // converting value in string
        guard let formattedCurrencyAmount = formatter.string(from: self) else {
            return nil
        }
        return formattedCurrencyAmount
    }
    
}
