//
//  APIError.swift
//  Strange news
//
//  Created by Hanna Karnaukh on 2/19/19.
//  Copyright © 2019 Hanna Karnaukh. All rights reserved.
//

import Foundation

enum APIError: Error {
    case requestFailed
    case decodableProcessFailed
    case invalidData
    case responseUnsuccessful
    
    var localizedDescription: String {
        switch self {
        case .requestFailed:
            return "Request Failed"
        case .decodableProcessFailed:
            return "Decodable Process Failed"
        case .invalidData:
            return "Invalid Data"
        case .responseUnsuccessful:
            return "Response Unsuccessful"
        }
    }
}
