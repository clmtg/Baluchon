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
        
        guard let url = components.url else {
            preconditionFailure(
                "Invalid URL components: \(components)"
            )
        }
        return url
    }
}

    // MARK: - Functions

extension CurrencyEndpoint {
    
    /// Return the endpoint to reach in order to retreive the latest rates
    /// - Returns: Endpoint to reach
    static func latest() -> URL {
        let endpoint = CurrencyEndpoint(path: "latest", queryItems: [
            .init(name: "access_key", value: ApiKeys.fixer),
        ])
        return endpoint.url
    }
}
