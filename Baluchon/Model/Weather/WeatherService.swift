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
    func retreiveWeatherFor(lat: String, lon: String, callback: @escaping (Result<weatherStruct, ServiceError>) -> Void) {
        task?.cancel()
        task = session.dataTask(with: locationBaseWeatherEndpoint(lat: lat, lon: lon)) { data, response, error in
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
    
    /// Generate the needed URL endpoint in order to retreive the current weather for a specific location
    /// - Parameters:
    ///   - lat: location latitude
    ///   - lon: location longitude
    /// - Returns: URL needed to perform rest call, using the location datas provided
    func locationBaseWeatherEndpoint(lat: String, lon: String) -> URL {
        return WeatherEndpoint(path: "weather", queryItems: [URLQueryItem(name: "lat", value: lat), URLQueryItem(name: "lon", value: lon)]).url
    }
}
