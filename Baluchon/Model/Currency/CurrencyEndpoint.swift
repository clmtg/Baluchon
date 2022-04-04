//
//  CurrencyEndpoint.swift
//  Baluchon
//
//  Created by Clément Garcia on 04/04/2022.
//

import Foundation

//Struct which defines endpoints for the Fixer api.
struct CurrencyEndpoint {
    
    // MARK: - Vars
    private let apikey = URLQueryItem(name: "access_key", value: "ec8f2dadd832383f4f0f2402f5747a43")
    
    //The endpoint to reach. (Part added after the api address. E.g.: myapi.com/path)
    var path: String
    
    //ParamS to add within the endpoints
    var queryItems: [URLQueryItem] = []
    
    //Full url endpoint
    var url: URL {
        var components = URLComponents()
    
        components.scheme = "http"
        components.host = "data.fixer.io"
        components.path = "/api/" + path
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
    
    //Endpoint for the latest rates
    static var latest: Self {
        CurrencyEndpoint(path: "latest")
    }
}
