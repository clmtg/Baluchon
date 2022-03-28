//
//  CurrencyStruct.swift
//  Baluchon
//
//  Created by Clément Garcia on 27/03/2022.
//

import Foundation

struct CurrencyStruct: Codable{
    let success: Bool
    let timestamp: Double
    let base: String
    let date: String
    let rates: [String: Double]
}



