//
//  String+Extension.swift
//  SwiftCustomKit
//
//  Created by eason on 2019/7/24.
//  Copyright © 2019 eason. All rights reserved.
//

import Foundation

// MARK: - Checking

extension String {
    
    /// 检查手机号（1开头， 11位数字）
    public var isPhoneNumber: Bool {
        let regex = "^1[0-9]{10}$"
        let pre = NSPredicate(format: "SELF MATCHES %@", regex)
        let e = pre.evaluate(with: self)
        return e
    }
    
    ///检查邮箱
    public var isMail: Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let pre = NSPredicate(format: "SELF MATCHES %@", regex)
        let e = pre.evaluate(with: self)
        return e
    }
    
    /// 格式化带分隔符金额
    public func handelSeparator() -> String{
        if self.count == 0 {
            return ""
        }
        let number = NSNumber(value: Int(self)!)
        //创建一个NumberFormatter对象
        let numberFormatter = NumberFormatter()
        // 设置Number显示样式
        numberFormatter.numberStyle = .none  // 小数形式
        numberFormatter.usesGroupingSeparator = true //设置用组分隔
        numberFormatter.groupingSeparator = "," //分隔符号
        numberFormatter.groupingSize = 3  //分隔位数
        //格式化
        let format = numberFormatter.string(from: number)!
        return format
    }
    
    /// 手机号脱敏
    public func replacePhone() -> String {
        let start = self.index(self.startIndex, offsetBy: 3)
        let end = self.index(self.startIndex, offsetBy: 7)
        let range = Range(uncheckedBounds: (lower: start, upper: end))
        return self.replacingCharacters(in: range, with: "****")
    }
    
    /// 将原始的url编码为合法的url
    public func urlEncoded() -> String {
        let encodeUrlString = self.addingPercentEncoding(withAllowedCharacters:
            .urlQueryAllowed)
        return encodeUrlString ?? ""
    }
    
    /// 将编码后的url转换回原始的url
    public func urlDecoded() -> String {
        return self.removingPercentEncoding ?? ""
    }
    
    /// 去掉所有空格
    public var removeAllSapce: String {
        return self.replacingOccurrences(of: " ", with: "", options: .literal, range: nil)
    }
}
