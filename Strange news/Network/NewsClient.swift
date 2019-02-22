//
//  NewsClient.swift
//  Strange news
//
//  Created by Hanna Karnaukh on 2/19/19.
//  Copyright © 2019 Hanna Karnaukh. All rights reserved.
//

import Foundation

final class NewsClient: APIClient {
    let session: URLSession
    
    init() {
        self.session = URLSession(configuration: .default)
    }
    
    func getTopHeadlines(category: String?,
                         country: String?,
                         source: String?,
                         searchText: String?,
                         page: Int = NewsPaging.startPage,
                         completion: @escaping (Result<News?, APIError>) -> Void) {
        
        let countryValue = country != nil ? ParamValues.country[country!] : nil
        let sourcesValu = source != nil ? ParamValues.source[source!] : nil
        
        var request = APIRouter.getTopHeadlines(category, countryValue, sourcesValu, searchText, page).request
        request.addValue(Constants.apiKey(), forHTTPHeaderField: Constants.apiKeyKey)
        
        fetch(with: request, decode: { json -> News? in
            guard let topHeadlines = json as? News else {
                return nil
            }
            return topHeadlines
        }, completion: completion)
    }
    
    func getEverything(searchText: String?,
                       source: String?,
                       page: Int = NewsPaging.startPage,
                       completion: @escaping (Result<News?, APIError>) -> Void) {
        
        let sourcesValu = source != nil ? ParamValues.source[source!] : nil
        
        var request = APIRouter.getEverything(searchText, sourcesValu, page).request
        request.setValue(Constants.apiKey(), forHTTPHeaderField: Constants.apiKeyKey)
        
        fetch(with: request, decode: { json -> News? in
            guard let news = json as? News else {
                return nil
            }
            return news
        }, completion: completion)
    }
}
