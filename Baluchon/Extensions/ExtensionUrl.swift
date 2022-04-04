//
//  ExtensionUrl.swift
//  Baluchon
//
//  Created by Clément Garcia on 04/04/2022.
//

import Foundation

extension URL {
    static func getApiKey(pListFile keyMaster: String, for service: String) -> String {
        
        // 1 - Retreive plist file path
        guard let filePath = Bundle.main.path(forResource: keyMaster, ofType: "plist") else {
            fatalError("Couldn't find file '\(keyMaster).plist'.")
        }
        // 2 - Read plist file (using file path from above) to get the related apiKey
        let plist = NSDictionary(contentsOfFile: filePath)
        guard let serviceKey = plist?.object(forKey: service) as? String else {
            fatalError("Couldn't find key '\(service)' in '\(keyMaster)).plist'.")
        }
        return serviceKey
    }
}
