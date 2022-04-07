//
//  TranslationService.swift
//  Baluchon
//
//  Created by Clément Garcia on 31/03/2022.
//

import Foundation

/// Class which handle the translation data needs for the Baluchon's app
class TranslationService {
    
    // MARK: - var    
    //Session and data task used to perform REST calls
    let session: URLSession
    
    //Class initializer
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    // MARK: - Functions
    func translateText(text: String?,from srcLang: String?, to targetLang: String?, callback: @escaping (Result<TranslationStruct, ServiceError>) -> Void){
        //Perform checks against input provided by user
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
        //At this stage, user provided all input needed to proceed
        session.dataTask(url: TranslationEndpoint.basic(for: text, to: targetLang), completionHandler: callback)
    
    }
}

