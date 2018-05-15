//
//  CryptoTV.swift
//  hork
//
//  Created by Karan Gupta on 4/15/18.
//  Copyright © 2018 Karan Gupta. All rights reserved.
//

import Foundation
import UIKit

        //Separating table view from each cell to update information
final class CryptoTableViewController: UITableViewController {
        //taking currencies from CurrencyType class
    let currencies: [CurrencyType] = [.btc, .eth, .ltc, .xrp]
    let reuseIdentifier = String(describing: CryptoTableViewCell.self)
        //having number of rows in int
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currencies.count
    }
        //having to display the names in string
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Cryptocurrency Prices"
    }
        //intitating each cell value
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        if let cryptoTableViewCell = tableViewCell as? CryptoTableViewCell {
            let currencyType = currencies[indexPath.row]
            cryptoTableViewCell.formatCell(withCurrencyType: currencyType)
        }
        
        return tableViewCell
    }
}

