//
//  HomeRepoProtocol.swift
//  Currency App
//
//  Created by Mohamed Khaled on 26/05/2023.
//

import Foundation
import RxSwift

protocol HomeRepoProtocol {
    func fetchCurrencyRate() -> Observable<Currency>
}
