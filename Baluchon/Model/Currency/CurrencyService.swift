//
//  CurrencyService.swift
//  Baluchon
//
//  Created by Clément Garcia on 27/03/2022.
//

import Foundation

class CurrencyService {
    
    //Singleton pattern
    static let shared = CurrencyService()
    
    init() {
    }
    
    //Fixer URL to reach the API
    private static let urlFixer = URL(string: "http://data.fixer.io/api/latest?access_key=5c23a9b10d02702cc8d59361ca78cc83")!
    
    
    // MARK: - Functions
    
    /// Description
    /// - Parameter callback: callback description
    func retreiveRates(callback: @escaping (Error?, CurrencyStruct?) -> Void) {
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: CurrencyService.urlFixer) { data, response, error in
            
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(ServiceError.corruptData, nil)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(ServiceError.unexpectedResponse, nil)
                    return
                }
                
                
                /* 2 implementations available here
                 
                 -----> 1. By using guard
                 
                 guard let responseJSON = try? JSONDecoder().decode(CurrencyStruct.self, from: data) else {
                 callback(ServiceError.jsonInvalid, nil)
                 return
                 }
                 
                 -----> 2. By using do cach
                 
                 */
                
                do {
                    let responseJSON = try JSONDecoder().decode(CurrencyStruct.self, from: data)
                    callback(nil, responseJSON)
                } catch  {
                    callback(ServiceError.jsonInvalid, nil)
                }
                
            }
        }
        task.resume()
    }
}
