//
//  Article.swift
//  Strange news
//
//  Created by Hanna Karnaukh on 2/15/19.
//  Copyright © 2019 Hanna Karnaukh. All rights reserved.
//

import Foundation

struct Article: Codable {
    let source: ArticleSource?
    let author: String?
    let title: String?
    let description: String?
    private let URLString: String?
    private let URLStringToImage: String?
    //let publishedAt: String?
    let content: String?
    
    var url: URL? {
        guard let unwrappedURLString = URLString else { return nil }
        return URL(string: unwrappedURLString)
    }
    
    var urlToImage: URL? {
        guard let unwrappedURLString = URLStringToImage else { return nil }
        return URL(string: unwrappedURLString)
    }
    
    enum CodingKeys: String, CodingKey {
        case source
        case author
        case title
        case description
        case URLString = "url"
        case URLStringToImage = "urlToImage"
       // case publishedAt
        case content
    }
}
