//
//  APIRouter.swift
//  Strange news
//
//  Created by Hanna Karnaukh on 2/16/19.
//  Copyright © 2019 Hanna Karnaukh. All rights reserved.
//

import Foundation

enum APIRouter {
    case getTopHeadlines(String?, String?, String?, String?, Int)
    case getEverything(String?, String, Int)
    case getSources(String?, String?)
}
 
extension APIRouter {
    var baseURL: URL {
        return URL(string: Constants.baseURL)!
    }

    var path: String {
        switch self {
        case .getTopHeadlines(_):
            return "/v2/top-headlines"
        case .getEverything(_):
            return "/v2/everything"
        case.getSources(_):
            return "/v2/sources"
        }
    }
    
    var parameters: [URLQueryItem] {
        switch self {
        case .getTopHeadlines(let category, let country, let sources, let searchText, let page):
            var items = [ URLQueryItem(name: QueryParameters.category, value: category),
                          URLQueryItem(name: QueryParameters.country, value: country),
                          URLQueryItem(name: QueryParameters.sources, value: sources),
                          URLQueryItem(name: QueryParameters.searchText, value: searchText),
                          URLQueryItem.init(name: QueryParameters.page, value: String(page))]
            if category == country && country == sources && sources == searchText && searchText == nil {
                items.append(URLQueryItem(name: QueryParameters.category, value: "business"))
            }
            return items
            
        case  .getEverything(let searchText, let source, let page):
            let items = [ URLQueryItem(name: QueryParameters.searchText, value: searchText),
                          URLQueryItem(name: QueryParameters.sources, value: source),
                          URLQueryItem.init(name: QueryParameters.page, value: String(page))]
            return items
            
        case .getSources(let category, let country):
            let items = [URLQueryItem(name: QueryParameters.category, value: category),
                         URLQueryItem(name: QueryParameters.country, value: country)]
            return items
        }
    }
    
    var urlComponents: URLComponents {
        var components = URLComponents(string: Constants.baseURL)!
        components.path = path
        components.queryItems = parameters.filter { $0.value != nil }
        return components
    }
    
    var request: URLRequest {
        let url = urlComponents.url!
        return URLRequest(url: url)
    }
}
