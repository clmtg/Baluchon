//
//  TranslationEndpoint.swift
//  Baluchon
//
//  Created by Clément Garcia on 06/04/2022.
//

import Foundation

//Struct which defines endpoints for the Deepl api.
struct TranslationEndpoint {
    
    // MARK: - Vars
    //The endpoint to reach. (Part added after the api address. E.g.: myapi.com/path)
    var path: String
    //ParamS to add within the endpoints
    var queryItems: [URLQueryItem] = []
    
    //Full url endpoint
    var url: URL {
        var components = URLComponents()
        
        components.scheme = "https"
        components.host = "api-free.deepl.com"
        components.path = "/v2/" + path
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

extension TranslationEndpoint {
    
    /// Return the endpoint to reach in order to retreive the translation requested
    /// - Parameters:
    ///   - text: Text to translate
    ///   - targetLanguage: Language to use for translation
    /// - Returns: Endpoint to reach
    static func basic(for text: String, to targetLanguage: String) -> URL {
        let endpoint = TranslationEndpoint(path: "translate", queryItems: [
            .init(name: "auth_key", value: ApiKeys.deepl),
            .init(name: "text", value: text),
            .init(name: "target_lang", value: targetLanguage),
        ])
        return endpoint.url
    }
}
