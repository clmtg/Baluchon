//
//  WeatherStruct.swift
//  Baluchon
//
//  Created by Clément Garcia on 29/03/2022.
//

import Foundation

//Struct which defines the weather conditions received from OpenWeather API
struct weatherStruct: Decodable {
    
    let coord: [String: Double]
    let weather: [Weather]
    let base: String
    let main: [String: Float]
    let timezone: Int
    let id: Int
    let name: String
    let cod: Int
    
}

struct Weather: Decodable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
