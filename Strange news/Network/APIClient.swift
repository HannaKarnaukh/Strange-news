//
//  APIClient.swift
//  Strange news
//
//  Created by Hanna Karnaukh on 2/18/19.
//  Copyright © 2019 Hanna Karnaukh. All rights reserved.
//

import Foundation

protocol APIClient {
    var session: URLSession { get }
    func fetch<T: Decodable>(with reuest: URLRequest, decode: @escaping (Decodable) -> T?, completion: @escaping (Result<T, APIError>) -> Void)
}

extension APIClient {
    typealias TaskJSONComplHandler = (Decodable?, APIError?) -> Void
    
    private func decodingTask<T: Decodable>(with request: URLRequest,
                                            type: T.Type,
                                            completion: @escaping TaskJSONComplHandler) -> URLSessionDataTask {
        
        let task = session.dataTask(with: request) { data, response, _ in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed)
                return
            }
            
            if httpResponse.statusCode == 200 {
                if var data = data {
                    do {
                        data.prepareToDecode()
                        let model = try JSONDecoder().decode(type, from: data)
                        completion(model, nil)
                    } catch {
                        completion(nil, .responseUnsuccessful)
                    }
                } else {
                    completion(nil, .invalidData)
                }
            } else {
                completion(nil, .responseUnsuccessful)
            }
        }
        return task
    }
    
    func fetch<T: Decodable>(with request: URLRequest,
                             decode: @escaping (Decodable) -> T?,
                             completion: @escaping (Result<T, APIError>) -> Void) {
        
        let task = decodingTask(with: request, type: T.self) { json, error in
            DispatchQueue.main.async {
                guard let json = json else {
                    if let error = error {
                        completion(Result.error(error))
                    } else {
                        completion(Result.error(.invalidData))
                    }
                    return
                }
                if let value = decode(json) {
                    completion(.succes(value))
                } else {
                    completion(.error(.decodableProcessFailed))
                }
            }
        }
        task.resume()
    }
}
