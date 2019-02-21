//
//  Constants.swift
//  Strange news
//
//  Created by Hanna Karnaukh on 2/17/19.
//  Copyright © 2019 Hanna Karnaukh. All rights reserved.
//

import Foundation

struct Constants {
    static let baseURL = "https://newsapi.org"
    static let apiKeyKey = "X-Api-Key"
    
    static func apiKey() -> String {
        guard let filePath = Bundle.main.path(forResource: "ApiKey", ofType: "plist"),
            let plist = NSDictionary(contentsOfFile: filePath) else {
            return ""
        }
        let value = plist.object(forKey: apiKeyKey) as? String
        return value ?? ""
    }
}
