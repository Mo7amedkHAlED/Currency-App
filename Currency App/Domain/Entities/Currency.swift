//
//  Currency.swift
//  Currency App
//
//  Created by Mohamed Khaled on 27/05/2023.
//

import Foundation

// MARK: - Currency
struct Currency: Codable, Hashable{
    let date: String
    let result: Double
    let query: Query?
}
// MARK: - Query
struct Query: Codable, Hashable {
    let amount: Double
    let from:  String
    let to: String
}

