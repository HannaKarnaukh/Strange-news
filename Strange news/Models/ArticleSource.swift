//
//  ArticleSource.swift
//  Strange news
//
//  Created by Hanna Karnaukh on 2/15/19.
//  Copyright © 2019 Hanna Karnaukh. All rights reserved.
//

import Foundation

struct ArticleSource {
    var idSource: String?
    var name: String?
}

extension ArticleSource: Codable {
    enum CodingKeys: String, CodingKey {
        case idSource = "id"
        case name
    }
}
