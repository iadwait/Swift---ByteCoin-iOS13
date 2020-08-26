//
//  ViewController.swift
//  ByteCoin
//
//  Created by Adwait Barkale on 26/08/20.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    //MARK:- IBOutlets
    @IBOutlet weak var lblByteCoin: UILabel!
    @IBOutlet weak var lblCurrencyName: UILabel!
    @IBOutlet weak var pickerCurrency: UIPickerView!
    
    //MARK:- Variable and Objects
    
    var coinManager = CoinManager()
    
    
    //MARK:- viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pickerCurrency.dataSource = self
        pickerCurrency.delegate = self
        coinManager.delegate = self
    }
}

//MARK:- UIPickerView DataSource and Delegate
extension ViewController: UIPickerViewDataSource,UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //print(coinManager.currencyArray[row])
        let selectedCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCurrency)
    }
}
//MARK:- CoinManagerDelegate
extension ViewController: CoinManagerDelegate
{
    func didReceiveByteCoinDetails(coinDetails: CoinModel) {
        DispatchQueue.main.async {
            self.lblByteCoin.text = String(format: "%.5f", coinDetails.byteCoinValue)
            self.lblCurrencyName.text = coinDetails.currencyName
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}
