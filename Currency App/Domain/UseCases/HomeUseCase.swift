//
//  HomeUseCase.swift
//  Currency App
//
//  Created by Mohamed Khaled on 27/05/2023.
//

import Foundation
import RxSwift

protocol HomeUseCase {
    func fetchCurrencyRate() -> Observable<Currency>
}

class HomeUseCaseImple: HomeUseCase {
    
    // MARK: - Variables
    private let repo: HomeRepoProtocol
    
    // MARK: - Init
    init(repo: HomeRepoProtocol = HomeRepoImple()) {
        self.repo = repo
    }
    
    // MARK: - Fetch Symbols Data
    func fetchCurrencyRate() -> Observable<Currency> {
        return repo.fetchCurrencyRate()
    }
}
