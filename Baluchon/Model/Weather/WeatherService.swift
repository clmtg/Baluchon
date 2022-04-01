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
    //OpenWeather URL to reach the API
    private static let urlOpenWeather = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=40.7127281&lon=-74.0060152&appid=a4b4a7ca2573a4498b50ac984573b1f9")!
    
    //Session and data task used to perform REST calls
    let session: URLSession
    var task: URLSessionDataTask?
    
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
    func retreiveWeatherFor(callback: @escaping (Result<weatherStruct, ServiceError>) -> Void) {
        task?.cancel()
        task = session.dataTask(with: WeatherService.urlOpenWeather) { data, response, error in
            guard let data = data, error == nil else {
                callback(.failure(.corruptData))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                callback(.failure(.unexpectedResponse))
                return
            }
            
            do {
                let responseJSON = try JSONDecoder().decode(weatherStruct.self, from: data)
                callback(.success(responseJSON))
            } catch  {
                callback(.failure(.jsonInvalid))
            }
        }
        task?.resume()
    }
}
