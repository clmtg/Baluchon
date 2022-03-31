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
    
    // MARK: - Functions
    
    /// Retreive the current weather for a given long and lat using the openweathermap API
    /// - Parameters:
    ///   - lon: longitude of the location weather data request
    ///   - lat: latitude of the location weather data request
    ///   - callback: how to process data once gathered
    func retreiveWeatherFor(lon: Double, lat: Double, callback: @escaping (Error?, weatherStruct?) -> Void) {
        
        let urlOpenWeather = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=a4b4a7ca2573a4498b50ac984573b1f9")!
        
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: urlOpenWeather) { data, response, error in
            
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    callback(ServiceError.corruptData, nil)
                    return
                }
                
                guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                    callback(ServiceError.unexpectedResponse, nil)
                    return
                }
                
                do {
                    let responseJSON = try JSONDecoder().decode(weatherStruct.self, from: data)
                    callback(nil, responseJSON)
                } catch  {
                    callback(ServiceError.jsonInvalid, nil)
                }
            }
        }
        task.resume()
    }
}
