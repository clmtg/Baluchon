//
//  TranslationService.swift
//  Baluchon
//
//  Created by Clément Garcia on 31/03/2022.
//

import Foundation

/// Class which handle the weather data needs for the Baluchon's app
class TranslationService {
    
    // MARK: - var
    private static let urlDeepl = URL(string: "https://api-free.deepl.com/v2/translate")!
    private let apiKey = "ef9ffa17-3fcd-034d-f6e6-8ecc52656c02:fx"
    
    //Session and data task used to perform REST calls
    let session: URLSession
    var task: URLSessionDataTask?
    
    //Class initializer
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    // MARK: - Functions
    func translateText(text: String?,from srcLang: String?, to targetLang: String?, callback: @escaping (Result<TranslationStruct, ServiceError>) -> Void){
        
        guard let text = text,  text.isEmpty == false else {
            callback(.failure(.missingText))
            return
        }
        guard let srcLang = srcLang,  srcLang.isEmpty == false else {
            callback(.failure(.missingSourceLangue))
            return
        }
        
        guard let targetLang = targetLang,  targetLang.isEmpty == false else {
            callback(.failure(.missingSourceLangue))
            return
        }
        
        var request = URLRequest(url: TranslationService.urlDeepl)
        request.httpMethod = "POST"
        let body = "text=\(text)&target_lang=\(targetLang)&auth_key=\(self.apiKey)"
        request.httpBody = body.data(using: .utf8)
        
        task?.cancel()
        task = session.dataTask(with: request, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                callback(.failure(.corruptData))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                callback(.failure(.unexpectedResponse))
                return
            }
            do {
                let responseJSON = try JSONDecoder().decode(TranslationStruct.self, from: data)
                callback(.success(responseJSON))
            } catch  {
                callback(.failure(.jsonInvalid))
            }
        })
        task?.resume()
    }
}

