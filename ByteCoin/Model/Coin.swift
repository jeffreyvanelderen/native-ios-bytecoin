//
//  Coin.swift
//  ByteCoin
//
//  Created by Jeffrey Vanelderen on 25/03/2024.
//  Copyright © 2024 The App Brewery. All rights reserved.
//

import Foundation

public struct Coin : Codable {
    let rate: Double;
    let time: String;
    let asset_id_base: String;
    let asset_id_quote: String;
}
