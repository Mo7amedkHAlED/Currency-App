//
//  Error.swift
//  Currency App
//
//  Created by Mohamed Khaled on 29/05/2023.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case noInternet
    case generalError
}

enum GeneralError: Error {
    case baseRate
    case targetRate
    case currencies
    case enterAllFields
    case invalidDirectory
    case dataEncodingFailed
    case fileNotFound
    case dataConversionFailed

}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .noData:
            return "No Data"
        case .noInternet:
            return "No Internet"
        case .generalError:
            return "Something went wrong, Please try again!"
        }
    }
}
