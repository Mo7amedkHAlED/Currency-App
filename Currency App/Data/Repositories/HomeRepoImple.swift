//
//  HomeRepoImple.swift
//  Currency App
//
//  Created by Mohamed Khaled on 27/05/2023.
//

import Foundation
import RxSwift

class HomeRepoImple: HomeRepoProtocol {
    
    private let networkService : APIService
    
    init(networkService:APIService = NetworkService()) {
        self.networkService = networkService
    }
    // MARK: - Fetch Symbols Data
    func fetchCurrencyRate() -> RxSwift.Observable<Currency> {
        let baseUrl = URL(string: "\(Constants.fixerBaseURL)\(Constants.fixorPath)")!
        let queryItems = [
            URLQueryItem(name: Constants.access_keyName, value: Constants.access_key ),
            URLQueryItem(name: Constants.format, value: "1")
        ]
        
        var urlComponents = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true)!
        urlComponents.queryItems = queryItems
        guard let url = urlComponents.url else {
            return Observable.error(NetworkError.invalidURL)
        }
        
        let request = URLRequest(url: url)
        return networkService.fetch(urlRequest: request).asObservable().flatMap { data -> Observable<Currency> in
            do {
                let currenciesRateList = try JSONDecoder().decode(Currency.self, from: data)
                return Observable.just(currenciesRateList)
            } catch {
                return Observable.error(NetworkError.generalError)
            }
        }
    }
}
