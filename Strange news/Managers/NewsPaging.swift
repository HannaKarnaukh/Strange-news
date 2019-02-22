//
//  NewsPaging.swift
//  Strange news
//
//  Created by Hanna Karnaukh on 2/20/19.
//  Copyright © 2019 Hanna Karnaukh. All rights reserved.
//

import Foundation

struct NewsPaging {
    private let pagingStep = 1
    private var page: Int
    var maxPagesCount: Int?
    
    static var startPage: Int {
        return 1
    }
    
    var currentPage: Int {
        return page
    }
    
    var category: String?
    var country: String?
    var source: String?
    var searchText: String?
    
    init() {
        page = pagingStep
    }
    
    mutating func increase() -> Int {
        guard let max = maxPagesCount else {
            return page
        }
        if page < max {
            page += pagingStep
        }
        return page
    }
    
    mutating func resetPaging() {
        category = nil
        country = nil
        source = nil
        searchText = nil
        page = pagingStep
    }
    
    func getKey(for param: String) -> String? {
        switch param {
        case QueryParameters.category:
            return category
        case QueryParameters.country:
            return country
        case QueryParameters.sources:
            return source
        default:
            return nil
        }
    }
    
    mutating func set(_ key: String?, for param: String) {
        switch param {
        case QueryParameters.category:
            category = key
        case QueryParameters.country:
            country = key
        case QueryParameters.sources:
            source = key
        default:
            return
        }
    }
}
