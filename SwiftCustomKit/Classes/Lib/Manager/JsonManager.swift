//
//  JsonManager.swift
//  EasyMoney
//
//  Created by eason on 2019/8/7.
//  Copyright © 2019 普惠. All rights reserved.
//
// 字典与model互转

import Foundation

public class JsonManager {

    // MARK: Prop
    /// 单例
    public static let manager = JsonManager()
    
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    /*
     mutableContainer: 允许将数据解析成json对象后，修改其中的数据
     mutableLeaves: 使解析出来的json对象的叶子节点的属性变为NSMutableString
     allowFragments: 允许被解析的json数据不是array或者dic包裹，可以是单个string值
     */
    
    /// 字典转为模型
    public func toModel<T>(_ type: T.Type, value: Any) -> T? where T : Decodable {
        guard let data = try? JSONSerialization.data(withJSONObject: value) else { return nil }
        decoder.nonConformingFloatDecodingStrategy = .convertFromString(positiveInfinity: "+Infinity", negativeInfinity: "-Infinity", nan: "NaN")
        return try? decoder.decode(type, from: data)
    }
    
    /// 模型转为字典
    public func encoder<T>(toDictionary model: T) -> Any? where T: Encodable {
        encoder.outputFormatting = .prettyPrinted
        guard let data = try? encoder.encode(model) else {
            return nil
        }
        guard let dict = try? JSONSerialization.jsonObject(with: data, options: [.mutableLeaves, .mutableContainers]) else {
            return nil
        }
        return dict
    }
    
    /// JSON字符串转为模型
    public func toModel<T>(_ type: T.Type, string: String) -> T? where T : Decodable {
        decoder.nonConformingFloatDecodingStrategy = .convertFromString(positiveInfinity: "+Infinity", negativeInfinity: "-Infinity", nan: "NaN")
        guard let str = try? decoder.decode(T.self, from: string.data(using: .utf8)!) else { return nil }
        return str
    }
    
    /// 模型转为JSON字符串
    public func encoder<T>(toString model: T) -> String? where T: Encodable {
        encoder.outputFormatting = .prettyPrinted
        guard let data = try? encoder.encode(model) else {
            return nil
        }
        guard let jsonStr = String(data: data, encoding: .utf8) else {
            return nil
        }
        return jsonStr
    }
    
    /// 字典转为JSON字符串
    public func toJSONString(dictionary: NSDictionary) -> String {
           if (!JSONSerialization.isValidJSONObject(dictionary)) {
               print("无法解析出JSONString")
               return ""
           }
        let data : NSData! = try? JSONSerialization.data(withJSONObject: dictionary, options: []) as NSData?
        let JSONString = NSString(data:data as Data,encoding: String.Encoding.utf8.rawValue)
        return JSONString! as String
       }
    
    /// JSON字符串转为字典
    public func toDictionary(jsonString: String) -> NSDictionary {
        let jsonData: Data = jsonString.data(using: .utf8)!
        let dict = try? JSONSerialization.jsonObject(with: jsonData, options: [.mutableLeaves, .mutableContainers])
        if dict != nil {
            return dict as! NSDictionary
        }
        return NSDictionary()
    }
    
    /// 读取本地JSON
    public func getConfiguration(resource: String) -> Any {
        if let path = Bundle.main.path(forResource: resource, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: [.mutableLeaves, .mutableContainers])
                return jsonResult
            } catch {
                // maybe lets throw error here
                return []
            }
        }
        return []
    }
}
