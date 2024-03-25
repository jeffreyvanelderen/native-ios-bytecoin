//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

public protocol CoinManagerDelegate: NSObjectProtocol {
    func onRetrieveCoin(coin: Coin) -> Void
    func onRetrieveCoinError(error: Error?) -> Void;
}

struct CoinManager {
    
    var delegate: CoinManagerDelegate? = nil;
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    private let apiKey = "6EC89963-0686-43DD-BABC-4A9646BB8909"
    
    public static let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getPrice(forCurrency currency: String) {
        // Consumer will retrieve result via its delegate
        fetch(url: "\(baseURL)/\(currency)?apiKey=\(apiKey)");
    }
    
    private func fetch(url: String) {
        if let url = URL(string: url) {
            let session = URLSession(configuration: .default);
            let task = session.dataTask(with: url) { data, response, error in
                if let result = parse(data: data, response: response, error: error) {
                    print("Retrieved coin :: \(result)");
                    delegate?.onRetrieveCoin(coin: result);
                }
            };
            task.resume();
        }
    }
    
    private func parse(data: Data?, response: URLResponse?, error: Error?) -> Coin? {
        if error != nil {
            print("Request error! \(error!)");
            delegate?.onRetrieveCoinError(error: error);
            return nil;
        }
        
        if let data = data {
            return decode(data);
        }
        return nil;
    }
    
    private func decode(_ data: Data) -> Coin? {
        let decoder = JSONDecoder();
        
        do {
            return try decoder.decode(Coin.self, from: data);
        } catch {
            print("CoinManager.decode() failed with error '\(error)'");
            delegate?.onRetrieveCoinError(error: error);
        }
        
        return nil;
    }
    
}
