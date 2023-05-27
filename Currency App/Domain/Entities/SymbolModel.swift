//
//  SymbolModel.swift
//  Currency App
//
//  Created by Mohamed Khaled on 27/05/2023.
//

import Foundation
// MARK: - SymbolModel
struct SymbolModel: Codable {
    let success: Bool
    let symbols: [String: String]
}
