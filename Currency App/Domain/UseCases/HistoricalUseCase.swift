//
//  HistoricalUseCase.swift
//  Currency App
//
//  Created by Mohamed Khaled on 30/05/2023.
//

import Foundation
import RxSwift

protocol HistoricalUseCase {
    func saveConversionResult(historicalItem: [HistoricalModel], list: inout [HistoricalModel])
    func readConversionResult() -> Observable<[HistoricalModel]>
}

class HistoricalUseCaseImple: HistoricalUseCase {
    
    // MARK: - Variables
    private let repo: HistoricalRepoProtocol
    
    // MARK: - Init
    init(repo: HistoricalRepoProtocol) {
        self.repo = repo
    }
    
    // MARK: - Methods
    func readConversionResult() -> Observable<[HistoricalModel]> {
        repo.readConversionResult()
    }
    
    func saveConversionResult(historicalItem: [HistoricalModel], list: inout [HistoricalModel]) {
        repo.saveConversionResult(historicalItem: historicalItem, list: &list)
    }
}

