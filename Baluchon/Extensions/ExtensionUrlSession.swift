//
//  ExtensionUrlSession.swift
//  Baluchon
//
//  Created by Clément Garcia on 06/04/2022.
//

import Foundation

//Extension to implement custom dataTask from URLSession using generic Type
extension URLSession {
    
    func dataTask<T: Decodable>(url: URL, completionHandler: @escaping (Result<T, ServiceError>) -> Void) {
        dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(.failure(.corruptData))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHandler(.failure(.unexpectedResponse))
                return
            }
            
            do {
                let responseJSON = try JSONDecoder().decode(T.self, from: data)
                completionHandler(.success(responseJSON))
            } catch  {
                completionHandler(.failure(.jsonInvalid))
            }
        }.resume()
    }
}
