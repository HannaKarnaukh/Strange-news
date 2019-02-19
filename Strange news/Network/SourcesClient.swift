//
//  SourcesClient.swift
//  Strange news
//
//  Created by Hanna Karnaukh on 2/19/19.
//  Copyright © 2019 Hanna Karnaukh. All rights reserved.
//

import Foundation

final class SourcesClient: APIClient {
    let session: URLSession

    init() {
        self.session = URLSession(configuration: .default)
    }
    
    func getWith(category: String?,
                 country: String?,
                 completion: @escaping (Result<Sources?, APIError>) -> Void) {
        
        var request = APIRouter.getSources(category, country).request
        request.setValue(Constants.apiKey, forHTTPHeaderField: Constants.apiKeyKey)
        
        fetch(with: request, decode: { json -> Sources? in
            guard let sources = json as? Sources else {
                return nil
            }
            return sources
        }, completion: completion)
    }
}
