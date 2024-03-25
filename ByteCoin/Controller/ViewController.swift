//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource {

    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var rateLabel: UILabel!

    var coinManager = CoinManager();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        coinManager.delegate = self;

        currencyPicker.dataSource = self;
        currencyPicker.delegate = self;
        
        // Load initial selected currency
        coinManager.getPrice(forCurrency: CoinManager.currencyArray.first!);
    }

    // number of components = number of COLUMNS
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CoinManager.currencyArray.count;
    }
}

extension ViewController: CoinManagerDelegate {
    
    func onRetrieveCoin(coin: Coin) {
        DispatchQueue.main.async {
            self.rateLabel.text = String(format: "%.2f", coin.rate);
            self.currencyLabel.text = coin.asset_id_quote;
        }
    }
    
    func onRetrieveCoinError(error: Error?) {
        print("onRetrieveCoinError :: \(String(describing: error))");
    }
    
    
}

extension ViewController: UIPickerViewDelegate  {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return CoinManager.currencyArray[row];
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        coinManager.getPrice(forCurrency: CoinManager.currencyArray[row]);
    }
}
