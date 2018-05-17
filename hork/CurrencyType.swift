//
//  CryptoMain.swift
//  hork
//
//  Created by Karan Gupta on 4/15/18.
//  Copyright © 2018 Karan Gupta. All rights reserved.
//

import Foundation
import UIKit

        //first having each crypto in a value of identification
enum CurrencyType: String {
        //calling data from cryptocompare
    var apiURL: URL? {
        let apiString = "https://min-api.cryptocompare.com/data/price?fsym=" + rawValue + "&tsyms=USD"
        return URL(string: apiString)
    }
        //need a selection indication
    case
    btc = "BTC",
    eth = "ETH",
    ltc = "LTC",
    xrp = "XRP"
        //calling image check google how to do it
    var image: UIImage {
        switch self {
        case .btc:
            return #imageLiteral(resourceName: "Bitcoin")
        case .eth:
            return #imageLiteral(resourceName: "Ethereum")
        case .ltc:
            return #imageLiteral(resourceName: "Litecoin")
        case .xrp:
            return #imageLiteral(resourceName: "Ripple")
        }
    }
        // what needs to be printed for each crypto
    var name: String {
        switch self {
        case .btc:
            return "Bitcoin"
        case .eth:
            return "Ethereum"
        case .ltc:
            return "Litecoin"
        case .xrp:
            return "Ripple"
        }
    }
        // Get value back as an NSNumber needs to be void and then use guard let
    func requestValue(completion: @escaping (_ value: NSNumber?) -> Void) {
        guard let apiURL = apiURL else {
            completion(nil)
            return
        }
        let request = URLSession.shared.dataTask(with: apiURL) { (data, response, error) in
        // Unwrap the data use guard let
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
        // Unwrap the JSON and read the USD key
        do {
            guard let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
                let value = json["USD"] as? NSNumber else {
                    completion(nil)
                    return
                }
                completion(value)
            }
        catch  {
                completion(nil)
            }
        }
        request.resume()
    }
}

