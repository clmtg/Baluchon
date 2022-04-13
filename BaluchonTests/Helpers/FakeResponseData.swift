//
//  FakeResponseData.swift
//  BaluchonTests
//
//  Created by Clément Garcia on 12/04/2022.
//

import Foundation
@testable import Baluchon

final class FakeResponseData {
    
    // MARK: - URL
    static let currencyUrl: URL = URL(string: "http://data.fixer.io/api/latest?access_key=\(ApiKeys.fixer)")!
    static let weatherUrl: URL = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=45.4333&lon=4.4&appid=\(ApiKeys.openWeather)&units=metric&lang=fr")!
    static let translationUrl: URL = URL(string: "https://api-free.deepl.com/v2/translate?auth_key=\(ApiKeys.deepl)&text=J'ai%20une%20voiture%20rouge&target_lang=EN-GB")!
    
    // MARK: - Responses
    static let validResponse = HTTPURLResponse(url: URL(string: "https://www.apple.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)!
    static let invalidResponse = HTTPURLResponse(url: URL(string: "https://www.apple.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)!
    
    // MARK: - Data
    static var currencyCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        return bundle.dataFromJson("Currency")
    }
    
    static var weatherCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        return bundle.dataFromJson("Weather")
    }
    
    static var translationCorrectData: Data {
        let bundle = Bundle(for: FakeResponseData.self)
        return bundle.dataFromJson("Translation")
    }
        
    static let incorrectData = "erreur".data(using: .utf8)!
}

// MARK: - Extensions related to Bundle
extension Bundle {
    
    /// Extract data to a json file
    /// - Parameter name: json file name
    /// - Returns: data
    func dataFromJson(_ name: String) -> Data {
        guard let mockURL = url(forResource: name, withExtension: "json"),
              let data = try? Data(contentsOf: mockURL) else {
            fatalError("Failed to load \(name) from bundle.")
        }
        return data
    }
}
