//
//  WeatherEndpoint.swift
//  Baluchon
//
//  Created by Clément Garcia on 04/04/2022.
//

import Foundation

//Struct which defines endpoints for the OpenWeather api.
struct WeatherEndpoint {
    
    // MARK: - Vars
    //The endpoint to reach. (Part added after the api address. E.g.: myapi.com/path)
    var path: String
    //ParamS to add within the endpoints
    var queryItems: [URLQueryItem] = []
    
    //Full url endpoint
    var url: URL {
        var components = URLComponents()
    
        components.scheme = "https"
        components.host = "api.openweathermap.org"
        components.path = "/data/2.5/" + path
        components.queryItems = queryItems
        
        guard let url = components.url else {
            preconditionFailure(
                "Invalid URL components: \(components)"
            )
        }
        return url
    }
}

    // MARK: - Functions
extension WeatherEndpoint {
    
    /// Return the endpoint to reach in order to get current weather data for a given location
    /// - Parameters:
    ///   - lat: latitude location
    ///   - lon: longitude location
    /// - Returns: Endpoint to reach
    static func weatherOneLocation(lat: String, lon: String) -> URL {
        let endpoint = WeatherEndpoint(path: "weather", queryItems: [
            .init(name: "lat", value: lat),
            .init(name: "lon", value: lon),
            .init(name: "appid", value: ApiKeys.openWeather),
            .init(name: "units", value: "metric"),
            .init(name: "lang", value: "fr")
        ])
        return endpoint.url
    }
}
