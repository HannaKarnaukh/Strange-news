//
//  Constants+Parameters.swift
//  Strange news
//
//  Created by Hanna Karnaukh on 2/18/19.
//  Copyright © 2019 Hanna Karnaukh. All rights reserved.
//

import Foundation

struct QueryParameters: Hashable {
    static let category = "category"
    static let country = "country"
    static let sources = "sources"
    static let searchText = "q"
    static let page = "page"
}

struct ParamValues {
    static let category = ["Business": "business", "Entertainment": "entertainment", "General": "general", "Health": "health", "Science": "science", "Sports": "sports", "Technology": "technology"]
    static let country = ["Argentina": "ae", "Australia": "ar"]
    static let source = ["ABC News": "abc-news"]
}
