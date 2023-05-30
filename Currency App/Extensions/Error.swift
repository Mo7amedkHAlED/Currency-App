//
//  Error.swift
//  Currency App
//
//  Created by Mohamed Khaled on 29/05/2023.
//

import Foundation

enum AppError: Error {
    case enterAllFields
    case baseRate
    case targetRate
    case currencies
    case invalidDirectory
    case dataEncodingFailed
    case fileNotFound
    case dataConversionFailed
    case invalidURL
    case noData
    case noInternet
    case generalError
}

extension AppError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noInternet:
            return "No Internet Connection, Please try again Later!"
        case .enterAllFields:
            return "You should fill all required data in order to continue"
        case .invalidURL:
            return "Invalid URL"
        case .noData:
            return "No Data"
        case .generalError:
            return "Something went wrong, Please try again!"
        case .baseRate:
            return  "baseRate"
        case .targetRate:
            return "targetRate"
        case .currencies:
            return "currencies"
        case .invalidDirectory:
            return "invalidDirectory"
        case .dataEncodingFailed:
            return "dataEncodingFailed"
        case .fileNotFound:
            return"fileNotFound"
        case .dataConversionFailed:
            return"dataConversionFailed"
        }
    }
}
