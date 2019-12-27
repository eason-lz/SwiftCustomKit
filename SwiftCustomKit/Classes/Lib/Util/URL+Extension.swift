//
//  URL+Extension.swift
//  SwiftCustomKit
//
//  Created by eason on 2019/8/7.
//  Copyright © 2019 eason. All rights reserved.
//

import Foundation

extension URL {
    public var parametersFromQueryString : [String: String]? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: true),
            let queryItems = components.queryItems else { return nil }
        return queryItems.reduce(into: [String: String]()) { (result, item) in
            result[item.name] = item.value
        }
    }
}
