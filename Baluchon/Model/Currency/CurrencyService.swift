//
//  CurrencyService.swift
//  Baluchon
//
//  Created by Clément Garcia on 27/03/2022.
//

import Foundation

class CurrencyService {
    
    // MARK: - Vars
    //Fixer api key from ApiKeys.plist file
    private var apiKey = URL.getApiKey(pListFile: "ApiKeys", for: "FixerApiKey")
    
    //Fixer URL to reach the API
    private static let urlFixer = URL(string: "http://data.fixer.io/api/latest?access_key=")!
    
    //Session and data task used to perform REST calls
    let session: URLSession
    var task: URLSessionDataTask?
    
    //Class initializer
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    // MARK: - Functions
    
    /// Description
    /// - Parameter callback: callback description
    func retreiveRates(callback: @escaping (Result<CurrencyStruct, ServiceError>) -> Void) {
        task?.cancel()
        task = session.dataTask(with: CurrencyService.urlFixer) { data, response, error in
            guard let data = data, error == nil else {
                callback(.failure(.corruptData))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                callback(.failure(.unexpectedResponse))
                return
            }
            
            /* 2 implementations available here
             
             -----> 1. By using guard
             
             guard let responseJSON = try? JSONDecoder().decode(CurrencyStruct.self, from: data) else {
             callback(.success(responseJSON))
             return
             }
             
             -----> 2. By using do cach
             
             */
            
            do {
                let responseJSON = try JSONDecoder().decode(CurrencyStruct.self, from: data)
                callback(.success(responseJSON))
            } catch  {
                callback(.failure(.jsonInvalid))
            }
        }
        task?.resume()
    }
    
    /// Convert an amount using the provided rates (The real purpose of this function is to keep the data logic within the model rather than the view controller)
    /// - Parameters:
    ///   - local: amount to convert
    ///   - rates: Exchanges rates
    /// - Returns: Amount converted
    func convertAmount(from local: Double, with rates: Double) -> Double {
        return local * rates
    }
}
