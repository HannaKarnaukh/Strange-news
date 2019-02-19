//
//  Result.swift
//  Strange news
//
//  Created by Hanna Karnaukh on 2/19/19.
//  Copyright © 2019 Hanna Karnaukh. All rights reserved.
//

import Foundation

enum Result<T, U> where U: Error {
    case succes(T)
    case error(U)
}
