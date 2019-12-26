//
//  UIViewController+Modal.swift
//  SwiftCustomKit
//
//  Created by eason on 2019/7/25.
//  Copyright © 2019 eason. All rights reserved.
//

import UIKit
import Presentr

fileprivate var _presentrKey: UInt8 = 0

extension UIViewController {
    public func alert(title: String? = nil, message: String? = nil) -> UIAlertController {
        let vc = UIAlertController(title: title, message: message, preferredStyle: .alert)
        self.present(vc, animated: true, completion: nil)
        return vc
    }
    
    public func actionSheet(title: String? = nil, message: String? = nil) -> UIAlertController {
        let vc = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        self.present(vc, animated: true, completion: nil)
        return vc
    }
}

extension UIAlertController {
    @discardableResult
    public func addOK(title: String, handler:((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        self.addAction(UIAlertAction(title: title, style: .default, handler: handler))
        return self
    }
    
    @discardableResult
    public func addCancel(title: String, handler:((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        self.addAction(UIAlertAction(title: title, style: .cancel, handler: handler))
        return self
    }
    
    @discardableResult
    public func addDestructive(title: String, handler:((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        self.addAction(UIAlertAction(title: title, style: .destructive, handler: handler))
        return self
    }
}

extension UIViewController {
    
    // MARK: - Public
    
    // MARK: Gunc
    /// Alert for UIAlertController
    public func alert(title: String? = nil,
               message: String? = nil,
               OKTitle: String? = nil,
               OKAction: ((UIAlertAction) -> Swift.Void)? = nil,
               CancelTitle: String? = nil,
               CancelAction: ((UIAlertAction) -> Swift.Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        if let OKTtl = OKTitle {
            alertController.addAction(UIAlertAction(title: OKTtl, style: .default, handler: OKAction))
        }
        if let CancelTtl = CancelTitle {
            alertController.addAction(UIAlertAction(title: CancelTtl, style: .cancel, handler: CancelAction))
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    /// Alert for UIAlertController
    public func alert(title: String? = nil,
               message: String? = nil,
               DestructiveTitle: String? = nil,
               DestructiveAction: ((UIAlertAction) -> Swift.Void)? = nil,
               CancelTitle: String? = nil,
               CancelAction: ((UIAlertAction) -> Swift.Void)? = nil) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        if let DestructiveTtl = DestructiveTitle {
            alertController.addAction(UIAlertAction(title: DestructiveTtl, style: .destructive, handler: DestructiveAction))
        }
        if let CancelTtl = CancelTitle {
            alertController.addAction(UIAlertAction(title: CancelTtl, style: .cancel, handler: CancelAction))
        }
        self.present(alertController, animated: true, completion: nil)
    }
    
    /// ActionsSheet for UIAlertController
    public func actionSheet(title: String? = nil,
                     message: String? = nil,
                     actions: String...,
        handler: ((UIAlertAction) -> Swift.Void)? = nil) {
        
        let actionSheetController = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        actions.forEach({ actionSheetController.addAction(UIAlertAction(title: $0, style: .default, handler: handler)) })
        actionSheetController.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    /// Alert for View Controller (show from center)
    public func alertCustom(viewController: UIViewController,
                     position: CGPoint = CGPoint(x: 0.5, y: 0.5),
                     size: CGSize,
                     dismissOnSwipe: Bool = true,
                     backgroundDecoration: UIView? = nil,
                     animated: Bool = true,
                     completion: (() -> Void)?) {
        
        let width = ModalSize.custom(size: Float(size.width))
        let height = ModalSize.custom(size: Float(size.height))
        let center = ModalCenterPosition.custom(centerPoint: CGPoint(x: self.view.bounds.width * position.x, y: self.view.bounds.height  * position.y))
        let customType = PresentationType.custom(width: width, height: height, center: center)
        let presenter = self._presentr
        presenter.presentationType = customType
        presenter.roundCorners = true
        presenter.dismissOnSwipe = dismissOnSwipe
        if dismissOnSwipe {
            presenter.backgroundTap = .dismiss
        } else {
            presenter.backgroundTap = .noAction
        }
        presenter.customBackgroundView = backgroundDecoration
        self.customPresentViewController(presenter, viewController: viewController, animated: animated, completion: completion)
    }
    
    /// Action Sheet for View Controller (show from bottom)
    public func actionSheetCustom(viewController: UIViewController,
                           height: CGFloat,
                           dismissOnTap: Bool = true,
                           roundCorners: Bool = true,
                           cornerRadius: CGFloat = 0,
                           animated: Bool = true,
                           completion: (() -> Void)?) {
        
        let msWidth = ModalSize.full
        let msHeight = ModalSize.custom(size: Float(height))
        let centerH: CGFloat = self.view.bounds.size.height - height + (height / 2)
        let bottomCenter = ModalCenterPosition.custom(centerPoint: CGPoint(x: self.view.bounds.size.width/2, y: centerH))
        let customType = PresentationType.custom(width: msWidth, height: msHeight, center: bottomCenter)
        let presenter = self._presentr
        presenter.presentationType = customType
        presenter.transitionType = TransitionType.custom(CoverVerticalFromBottomAnimation())
        presenter.dismissTransitionType = TransitionType.custom(CoverVerticalFromBottomAnimation())
        presenter.roundCorners = roundCorners
        presenter.cornerRadius = cornerRadius
        presenter.dismissOnSwipe = dismissOnTap
        if dismissOnTap {
            presenter.backgroundTap = .dismiss
        } else {
            presenter.backgroundTap = .noAction
        }
        self.customPresentViewController(presenter, viewController: viewController, animated: animated, completion: completion)
    }
    
    /// notice for view controller (show from top)
    public func noticeCustom(viewController: UIViewController,
                      height: CGFloat,
                      dismissOnSwipe: Bool = true,
                      roundCorners: Bool = true,
                      cornerRadius: CGFloat = 0,
                      animated: Bool = true,
                      completion: (() -> Void)?) {
        
        let msWidth = ModalSize.full
        let msHeight = ModalSize.custom(size: Float(height))
        let topCenter = ModalCenterPosition.customOrigin(origin: CGPoint(x: 0, y: 0))
        let customType = PresentationType.custom(width: msWidth, height: msHeight, center: topCenter)
        let presenter = self._presentr
        presenter.presentationType = customType
        presenter.transitionType = TransitionType.coverVerticalFromTop
        presenter.dismissTransitionType = TransitionType.coverVerticalFromTop
        presenter.roundCorners = roundCorners
        presenter.cornerRadius = cornerRadius
        presenter.dismissOnSwipe = dismissOnSwipe
        if dismissOnSwipe {
            presenter.backgroundTap = .dismiss
        } else {
            presenter.backgroundTap = .noAction
        }
        self.customPresentViewController(presenter, viewController: viewController, animated: animated, completion: completion)
    }
    
    // MARK: - Private
    
    // MARK: _Prop
    /// Presentr对象的私有关联属性, Not Nil
    private var _presentr: Presentr {
        if let p = objc_getAssociatedObject(self, &_presentrKey) as? Presentr {
            return p
        } else {
            let p = Presentr(presentationType: .alert)
            p.transitionType = TransitionType.crossDissolve
            p.dismissTransitionType = TransitionType.crossDissolve
            p.keyboardTranslationType = .moveUp
            objc_setAssociatedObject(self, &_presentrKey, p, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return p
        }
    }
}

/// Cover Vertical From Bottom Animation
public class CoverVerticalFromBottomAnimation: PresentrAnimation {
    
    override public func transform(containerFrame: CGRect, finalFrame: CGRect) -> CGRect {
        var initialFrame = finalFrame
        initialFrame.origin.y = finalFrame.maxY
        return initialFrame
    }
}

