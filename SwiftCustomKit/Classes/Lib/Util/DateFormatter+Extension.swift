//
//  DateFormatter+Extension.swift
//  SwiftCustomKit
//
//  Created by eason on 2018/3/20.
//  Copyright © 2018年 eason. All rights reserved.
//

import Foundation

private let _fmter: DateFormatter = DateFormatter()

extension Int {
    public func dateFormatForSecond(_ fmt: String = "yyyy.MM.dd HH:mm") -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        _fmter.dateFormat = fmt
        return _fmter.string(from: date)
    }
    
    public func dateFormatForMillisecond(_ fmt: String = "yyyy.MM.dd HH:mm") -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self/1000))
        _fmter.dateFormat = fmt
        return _fmter.string(from: date)
    }
}

extension Double {
    public func dateFormatForSecond(_ fmt: String = "yyyy.MM.dd HH:mm") -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self))
        _fmter.dateFormat = fmt
        return _fmter.string(from: date)
    }
    
    public func dateFormatForMillisecond(_ fmt: String = "yyyy.MM.dd HH:mm") -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(self/1000))
        _fmter.dateFormat = fmt
        return _fmter.string(from: date)
    }
}

extension Date {
    public func dateFormat(_ fmt: String = "yyyy.MM.dd HH:mm") -> String {
        _fmter.dateFormat = fmt
        return _fmter.string(from: self)
    }
}
