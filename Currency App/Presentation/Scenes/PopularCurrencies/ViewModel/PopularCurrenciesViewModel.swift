//
//  PopularCurrenciesViewModel.swift
//  Currency App
//
//  Created by Mohamed Khaled on 30/05/2023.
//

import Foundation
import RxSwift
import RxRelay

class PopularCurrenciesViewModel {
    // MARK: - Variables
    var baseCurrency : String?
    var currencies: Currency?
    let popularCurrenciesSymbols = ["USD", "GBP", "CAD", "AUD", "JPY", "CHF", "CNY", "INR", "ZAR", "SAR"]
    var popularCurrenciesList: BehaviorRelay<[PopularCurrencies]> = .init(value: [])
    
    
    // MARK: - viewDidLoad
    func viewDidLoad() {
        convertToPopularCurrencies()
    }
    
    func convertToPopularCurrencies () {
        guard let baseCurrency = baseCurrency else { return }
        for currency in popularCurrenciesSymbols {
            convert(from: baseCurrency, to: currency)
                .subscribe(onNext: { [weak self] convertedAmount in
                    guard let self  else { return }
                    let popularCurrency = PopularCurrencies(currency: currency, rate: convertedAmount)
                    
                    // Update the value of popularCurrenciesList
                    var currentCurrencies = self.popularCurrenciesList.value
                    currentCurrencies.append(popularCurrency)
                    self.popularCurrenciesList.accept(currentCurrencies)
                }, onError: { error in
                    print("Error: \(error.localizedDescription)")
                })
                .disposed(by: DisposeBag())
        }
    }
    
    // convert currency method
    private func convert(from baseCurrency: String, to targetCurrency: String) -> Observable<Float> {
        
        guard let currencies = currencies else {
            return Observable.error(AppError.currencies)
        }
        
        guard let baseRate = currencies.rates[baseCurrency] else {
            return Observable.error(AppError.baseRate)
        }
        
        guard let targetRate = currencies.rates[targetCurrency] else {
            return Observable.error(AppError.targetRate)
        }
        
        let convertedAmount = (1 / baseRate) * targetRate
        return Observable.just(convertedAmount)
    }
    
}
