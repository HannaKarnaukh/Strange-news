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
                         sources: String?,
                         searchText: String?,
                         page: Int = 0,
                         completion: @escaping (Result<News?, APIError>) -> Void) {
        
        var request = APIRouter.getTopHeadlines(category, country, sources, searchText, page).request
        request.addValue(Constants.apiKey, forHTTPHeaderField: Constants.apiKeyKey)
        
        fetch(with: request, decode: { json -> News? in
            guard let topHeadlines = json as? News else {
                return nil
            }
            return topHeadlines
        }, completion: completion)
    }
    
    func getEverything(searchText: String?,
                       source: String = "all",
                       page: Int = 2,
                       completion: @escaping (Result<News?, APIError>) -> Void) {
        
        var request = APIRouter.getEverything(searchText, source, page).request
        request.setValue(Constants.apiKey, forHTTPHeaderField: Constants.apiKeyKey)
        
        fetch(with: request, decode: { json -> News? in
            guard let news = json as? News else {
                return nil
            }
            return news
        }, completion: completion)
    }
}
