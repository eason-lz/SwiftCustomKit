//
//  HUD+Extension.swift
//  SwiftCustomKit
//
//  Created by eason on 2019/7/24.
//  Copyright © 2019 eason. All rights reserved.
//

import PKHUD

extension HUD {
    
    /// Show an auto-hidden message
    public static func message(_ msg: String, onView: UIView? = nil, completion: ((Bool) -> Void)? = nil) {
        
        var delay: TimeInterval = TimeInterval(msg.count) * 0.10
        delay = delay > 10 ? 10 : delay
        guard delay > 0 else {return}
        
        let lb = SimpleLabel()
        lb.text = msg
        lb.sizeToFit()
        PKHUD.sharedHUD.dimsBackground = false
        PKHUD.sharedHUD.userInteractionOnUnderlyingViewsEnabled = true
        PKHUD.sharedHUD.contentView = lb
        PKHUD.sharedHUD.show(onView: onView)
        PKHUD.sharedHUD.hide(afterDelay: delay, completion: completion)
    }
    
    /// Show Activity
    public static func activity(onView: UIView? = nil) {
        PKHUD.sharedHUD.dimsBackground = false
        PKHUD.sharedHUD.userInteractionOnUnderlyingViewsEnabled = false
        PKHUD.sharedHUD.contentView = PKHUDSystemActivityIndicatorView()
        PKHUD.sharedHUD.show(onView: onView)
    }
}

extension HUD {
    
    /// 单个message样式
    class SimpleLabel: UILabel {
        static let maxWidth: CGFloat = 250
        static let textEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        static let maxNumberOfLines: Int = 10
        
        convenience init() {
            self.init(frame: CGRect.zero)
            self.backgroundColor = UIColor(0x1C1C1CFF).withAlphaComponent(0.7)
            self.textAlignment = .left
            self.textColor = UIColor(0xFFFFFFFF)
            self.font = UIFont.reg(14)//CF.reg(14)
            self.layer.cornerRadius = 4
            self.layer.masksToBounds = true
            self.numberOfLines = SimpleLabel.maxNumberOfLines
            self.lineBreakMode = .byTruncatingTail
        }
        
        override func sizeThatFits(_ size: CGSize) -> CGSize {
            
            var size = super.sizeThatFits(CGSize(width: SimpleLabel.maxWidth - SimpleLabel.textEdgeInsets.left - SimpleLabel.textEdgeInsets.right, height: CGFloat(Int.max)))
            size.width += SimpleLabel.textEdgeInsets.left + SimpleLabel.textEdgeInsets.right
            size.height += SimpleLabel.textEdgeInsets.top + SimpleLabel.textEdgeInsets.bottom
            return size
        }
        
        override func drawText(in rect: CGRect) {
            let rect = CGRect(x: SimpleLabel.textEdgeInsets.left,
                              y: SimpleLabel.textEdgeInsets.top,
                              width: rect.width - SimpleLabel.textEdgeInsets.left - SimpleLabel.textEdgeInsets.right,
                              height: rect.height - SimpleLabel.textEdgeInsets.top - SimpleLabel.textEdgeInsets.bottom)
            super.drawText(in: rect)
        }
    }
}
