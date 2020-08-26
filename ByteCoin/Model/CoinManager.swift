//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Adwait Barkale on 26/08/20.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didReceiveByteCoinDetails(coinDetails: CoinModel)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "F79DF4EC-F32A-4B8E-9BFA-341BAB36EC1D"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    var delegate: CoinManagerDelegate?
    
    func getCoinPrice(for currency: String)
    {
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString:String)
    {
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data{
                    if let coinDetails = self.parseJSON(safeData){
                        self.delegate?.didReceiveByteCoinDetails(coinDetails: coinDetails)
                    }
                }
                
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data:Data) -> CoinModel?
    {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(CoinData.self, from: data)
            let byteCoinPrice = decodedData.rate
            let currency = decodedData.asset_id_quote
            let coinModel = CoinModel(currencyName: currency, byteCoinValue: byteCoinPrice)
            return coinModel
        }catch{
            print(error)
            delegate?.didFailWithError(error: error)
        }
        return nil
    }
}

