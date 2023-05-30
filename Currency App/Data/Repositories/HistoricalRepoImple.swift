//
//  HistoricalRepoImple.swift
//  Currency App
//
//  Created by Mohamed Khaled on 30/05/2023.
//

import Foundation
import RxSwift

class HistoricalRepoImple: HistoricalRepoProtocol {
    
    private let fileName = "conversion_result.json"
    
    func readConversionResult() -> Observable<[HistoricalModel]> {
        return Observable.create { observer in
            guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
                observer.onError(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Documents directory not found."]))
                return Disposables.create()
            }
            
            let fileURL = documentsDirectory.appendingPathComponent(self.fileName)
            
            do {
                let fileData = try Data(contentsOf: fileURL)
                let results = try JSONDecoder().decode([HistoricalModel].self, from: fileData)
                observer.onNext(results.uniqued())
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            
            return Disposables.create()
        }
    }
    
    func saveConversionResult(historicalItem: [HistoricalModel], list: inout [HistoricalModel]) {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return
        }
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        
        // Check if the file exists
        let fileExists = FileManager.default.fileExists(atPath: fileURL.path)
        
        do {
            if fileExists {
                // This opens the existing file in read mode and loads its content as an array
                let fileData = try Data(contentsOf: fileURL)
                let existingResults = try JSONDecoder().decode([HistoricalModel].self, from: fileData)
                
                // Append the new historical items to the existing results array
                list = existingResults + historicalItem
            } else {
                // If the file doesn't exist, set the conversion results to the new historical items
                list = historicalItem
            }
            
            // Encode the updated conversion results array to JSON data
            let jsonData = try JSONEncoder().encode(list)
            
            // Write the data to the file
            try jsonData.write(to: fileURL)
            
        } catch {
            print("Error writing to JSON file: \(error)")
        }
    }
}
