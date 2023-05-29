//
//  HistoricalModel.swift
//  Currency App
//
//  Created by Mohamed Khaled on 29/05/2023.
//

import Foundation

struct HistoricalModel: Codable {
    let amount: String
    let date: String
    let fromCurrency: String
    let toCurrency: String
    let result: Float
}
