//
//  WeatherService.swift
//  Baluchon
//
//  Created by Clément Garcia on 29/03/2022.
//

import Foundation

/// Class which handle the weather data needs for the Baluchon's app
class WeatherService {
    
    // MARK: - Vars
    //Session and data task used to perform REST calls
    let session: URLSession
    
    //Class initializer
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    // MARK: - Functions
    /// Retreive the current weather for a given long and lat using the openweathermap API
    /// - Parameters:
    ///   - lon: longitude of the location weather data request
    ///   - lat: latitude of the location weather data request
    ///   - callback: how to process data once gathered
    func retreiveWeatherFor(lat: String, lon: String, callback: @escaping (Result<weatherStruct, ServiceError>) -> Void) {
        session.dataTask(url: WeatherEndpoint.weatherOneLocation(lat: lat, lon: lon), completionHandler: callback)
    }
}
