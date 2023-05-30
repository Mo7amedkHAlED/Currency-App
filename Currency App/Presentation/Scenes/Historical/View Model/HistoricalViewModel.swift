//
//  HistoricalViewModel.swift
//  Currency App
//
//  Created by Mohamed Khaled on 29/05/2023.
//

import Foundation
import RxSwift
import RxRelay

class HistoricalViewModel {
    // MARK: - Variables
    private let historicalUseCase: HistoricalUseCase
    var historicalPublisher: PublishSubject<[HistoricalModel]> = .init()
    private let bag = DisposeBag()
    
    // MARK: - Init
    init(historicalUseCase: HistoricalUseCase = HistoricalUseCaseImple(repo: HistoricalRepoImple())) {
        self.historicalUseCase = historicalUseCase
    }
    
    func viewDidLoad() {
        readConversionResult().subscribe(onNext: { [weak self] currencyHistorical in
            // The saving process completed successfully
            guard let self else { return }
            self.historicalPublisher.onNext(currencyHistorical)
        }, onError: { error in
            // Handle the error case
            print("Error saving currency: \(error)")
        }).disposed(by: bag)
        
        
    }
    
    private func readConversionResult() -> Observable<[HistoricalModel]> {
        historicalUseCase.readConversionResult()
    }
}
