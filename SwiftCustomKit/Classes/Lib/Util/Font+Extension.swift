//
//  Config+Font.swift
//  SwiftCustomKit
//
//  Created by eason on 2019/7/24.
//  Copyright © 2019 eason. All rights reserved.
//

import UIKit

extension UIFont {
    public class func lig(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .light)
    }
    
    public class func reg(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .regular)
    }
    
    public class func med(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .medium)
    }

    public class  func sem(_ size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size, weight: .semibold)
    }
}
