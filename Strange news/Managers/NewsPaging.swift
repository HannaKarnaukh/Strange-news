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
}
