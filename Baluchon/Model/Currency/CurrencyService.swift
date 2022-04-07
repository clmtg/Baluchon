//
//  CurrencyService.swift
//  Baluchon
//
//  Created by Clément Garcia on 27/03/2022.
//

import Foundation

class CurrencyService {
    
    // MARK: - Vars
    //Session and data task used to perform REST calls
    let session: URLSession
    
    //Class initializer
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    // MARK: - Functions
    
    /// Description
    /// - Parameter callback: callback description
    func retreiveRates(callback: @escaping (Result<CurrencyStruct, ServiceError>) -> Void) {
        session.dataTask(url: CurrencyEndpoint.latest(), completionHandler: callback)
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
