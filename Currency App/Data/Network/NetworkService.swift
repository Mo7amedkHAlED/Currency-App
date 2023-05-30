//
//  NetworkService.swift
//  Currency App
//
//  Created by Mohamed Khaled on 26/05/2023.
//

import Foundation
import RxSwift

protocol APIService {
    func fetch(urlRequest: URLRequest) -> Observable<Data>
}

class NetworkService: APIService {
    
    func fetch(urlRequest: URLRequest) -> Observable<Data> {
        return Observable.create { observer in
            
            // Check for internet connectivity
            guard Reachability.isConnectedToNetwork() else {
                observer.onError(AppError.noInternet)
                return Disposables.create()
            }
            
            let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
                if let error = error {
                    observer.onError(error)
                    return
                }
                
                guard let responseData = data else {
                    observer.onError(AppError.noData)
                    return
                }
                
                observer.onNext(responseData)
                observer.onCompleted()
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
}
