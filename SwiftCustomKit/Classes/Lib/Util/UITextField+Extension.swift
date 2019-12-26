//
//  UITextField+Extension.swift
//  SwiftCustomKit
//
//  Created by eason on 2019/7/29.
//  Copyright © 2019 eason. All rights reserved.
//

import UIKit

extension UITextField {
    
    public func addAccessoryButton(title: String?, target:Any, action: Selector) {
        let bbiSpace = UIBarButtonItem.init(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        let bbiBtn = UIBarButtonItem.init(title: title, style: .plain, target: target, action: action)

        let tb = UIToolbar.init(frame: CGRect(x: 0, y: 0, width: 0, height: 44))
        tb.barTintColor = UIColor.white
        tb.items = [bbiSpace, bbiBtn]
        self.inputAccessoryView = tb
    }
}
