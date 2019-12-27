//
//  Util.swift
//  SwiftCustomKit
//
//  Created by eason on 2019/7/24.
//  Copyright © 2019 eason. All rights reserved.
//

import Foundation


public func dlog(_ items: Any..., function: String = #function, line: Int = #line){
    #if DEBUG
        let desc = items.reduce("", {return $0 + String(describing: $1)})
        let header = "[\(line)] \(function)"
        print("\(header) \n \(desc)", terminator:"\n\n")
    #endif
}

/// async to main
public func asyncToMain(_ work: @escaping () -> Void) {
    DispatchQueue.main.async(execute: work)
}

/// async to global
public func asyncToGlobal(_ work: @escaping () -> Void) {
    DispatchQueue.global().async(execute: work)
}

/// debug only
public func debugOnly(_ condition: () -> Void) {
    assert({condition(); return true}())
}



