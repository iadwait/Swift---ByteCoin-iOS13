//
//  CoinData.swift
//  ByteCoin
//
//  Created by Adwait Barkale on 26/08/20.
//  Copyright © 2020 The App Brewery. All rights reserved.
//

import Foundation


struct CoinData: Codable
{
    var time: String
    var asset_id_base: String
    var asset_id_quote: String
    var rate: Double
}
