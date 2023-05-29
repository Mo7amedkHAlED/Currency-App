//
//  Currency.swift
//  Currency App
//
//  Created by Mohamed Khaled on 27/05/2023.
//

import Foundation
// MARK: - Currency
struct Currency: Codable {
    let success: Bool
    let timestamp: Int
    let base, date: String
    let rates: [String: Float]
}
