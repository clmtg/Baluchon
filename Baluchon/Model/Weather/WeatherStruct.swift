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
    let visibility: Int
    let wind: [String: Float]
    let clouds: [String: Int]
    let dt: Double
    let sys: Sys
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

struct Sys: Decodable {
    let type: Int
    let id: Int
    let country: String
    let sunrise: Double
    let sunset: Double
}
