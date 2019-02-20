//
//  Extentions.swift
//  Strange news
//
//  Created by Hanna Karnaukh on 2/19/19.
//  Copyright © 2019 Hanna Karnaukh. All rights reserved.
//

import Foundation
import UIKit

extension Data {
    mutating func prepareToDecode() {
        guard var string = String(data: self, encoding: .utf8) else {
            return
        }
        string = string.replacingOccurrences(of: "\r", with: " ").replacingOccurrences(of: "\n", with: " ")
        self = string.data(using: .utf8)!
    }
}
