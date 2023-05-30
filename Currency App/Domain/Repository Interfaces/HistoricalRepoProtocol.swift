//
//  HistoricalRepoProtocol.swift
//  Currency App
//
//  Created by Mohamed Khaled on 30/05/2023.
//

import Foundation
import RxSwift

protocol HistoricalRepoProtocol {
    func readConversionResult() -> Observable<[HistoricalModel]>
    func saveConversionResult(historicalItem: [HistoricalModel], list: inout [HistoricalModel])
}
