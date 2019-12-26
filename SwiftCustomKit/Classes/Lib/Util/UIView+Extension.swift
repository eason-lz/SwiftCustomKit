//
//  UIView+Extension.swift
//  SwiftCustomKit
//
//  Created by eason on 2019/7/24.
//  Copyright © 2019 eason. All rights reserved.
//

import UIKit

// SafeArea
extension UIView {
    
    /// availableSafeAreaInsets
    public var availableSafeAreaInsets: UIEdgeInsets {
        if #available(iOS 11.0, *){
            let insets = self.safeAreaInsets
            return insets
        } else {
            return UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 0)
        }
    }
}

extension UIView {
    public func clipToCorners(_ corners: UIRectCorner, cornerRadius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let ly = CAShapeLayer()
        ly.path = path.cgPath
        self.layer.mask = ly
    }
}

/// Create
extension UIView {
    
    /// Create & Add & Return LayoutGuide
    public func createSubLayoutGuide() -> UILayoutGuide {
        let g = UILayoutGuide()
        self.addLayoutGuide(g)
        return g
    }
    
    /// Create & add sub generic-type view
    public func createSubView<V: UIView>() -> V? {
        let v = V()
        v.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            (v as? UIScrollView)?.contentInsetAdjustmentBehavior = .never
        }
        self.addSubview(v)
        return v
    }
    
    /// Create & add sub UITableView
    public func createSubTableView(style: UITableView.Style = .plain) -> UITableView {
        let v = UITableView(frame: CGRect.zero, style: style)
        if #available(iOS 11.0, *) {
            v.contentInsetAdjustmentBehavior = .never
            v.estimatedRowHeight = 0
            v.estimatedSectionHeaderHeight = 0
            v.estimatedSectionFooterHeight = 0
        }
        v.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(v)
        return v
    }
    
    ///
    public func createSubCollectionView(layout: UICollectionViewLayout = {
        let ly = UICollectionViewFlowLayout()
        ly.scrollDirection = .vertical
        return ly
        }()) -> UICollectionView {
        
        let v = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        if #available(iOS 11.0, *) {
            v.contentInsetAdjustmentBehavior = .never
        }
        v.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(v)
        return v
    }
}

// Create
extension UIStackView {
    /// Create & add arranged sub generic-type view
    public func createArrangedView<V: UIView>() -> V? {
        let v = V()
        v.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            (v as? UIScrollView)?.contentInsetAdjustmentBehavior = .never
        }
        self.addArrangedSubview(v)
        return v
    }
}
