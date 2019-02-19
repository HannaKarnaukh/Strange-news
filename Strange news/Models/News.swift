//
//  News.swift
//  Strange news
//
//  Created by Hanna Karnaukh on 2/15/19.
//  Copyright © 2019 Hanna Karnaukh. All rights reserved.
//

import Foundation

struct News: Codable {
    let totalResultsCount: Int?
    var articles: [Article]
    
    enum CodingKeys: String, CodingKey {
        case totalResultsCount = "totalResults"
        case articles
    }
}
