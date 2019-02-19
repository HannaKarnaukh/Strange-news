//
//  Source.swift
//  Strange news
//
//  Created by Hanna Karnaukh on 2/15/19.
//  Copyright © 2019 Hanna Karnaukh. All rights reserved.
//

import Foundation

struct Source: Codable {
    var id: String
    var name: String
    var description: String
    var URLString: String
    var category: String
    var language: String
    var country: String
    
    var url: URL? {
        return URL(string: URLString)
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case URLString = "url"
        case category
        case language
        case country
    }
}
