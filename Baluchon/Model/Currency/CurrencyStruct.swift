//
//  CurrencyStruct.swift
//  Baluchon
//
//  Created by Clément Garcia on 27/03/2022.
//

import Foundation

//Struct which defines the exchanges rates provided by the API
struct CurrencyStruct: Decodable{
    let base: String //Which base currency is used. In this case it should be EUR
    let rates: [String: Double] //Country code and related exchanges rates
}
