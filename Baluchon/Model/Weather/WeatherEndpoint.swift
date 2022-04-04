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
    private let apikey = URLQueryItem(name: "appid", value: "c92a42bb4cc3d698309ee68234129dcc")
    
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
        components.queryItems?.append(apikey)
        
        guard let url = components.url else {
            preconditionFailure(
                "Invalid URL components: \(components)"
            )
        }
        return url
    }
    
    // MARK: - Vars Statics
    
    //Endpoint for the current weather
    static var weather: Self {
        WeatherEndpoint(path: "weather")
    }
}
